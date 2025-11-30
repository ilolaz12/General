"""Program to convert Tritium clog format files to Vehicle Spy binary files"""
import ctypes
import struct
import sys


class ClogHeader(ctypes.LittleEndianStructure):
    """Header at the top of a clog file"""
    _pack_ = True
    _fields_ = [
        ('version', ctypes.c_uint8),
        ('flags', ctypes.c_uint8),
        ('reserved', ctypes.c_uint16),
        ('time_start', ctypes.c_uint32),
        ('log_count', ctypes.c_uint32),
        ('crc32', ctypes.c_uint32),
    ]


class ClogMessage(ctypes.LittleEndianStructure):
    """Per message structure from a clog"""
    _pack_ = True
    _fields_ = [
        ('can_id', ctypes.c_uint32),
        ('data', ctypes.c_uint8 * 8),
        ('diff_time', ctypes.c_int32),
    ]


class VsbMessage(ctypes.LittleEndianStructure):
    """Per message structure in a vsb file"""
    _pack_ = True
    _fields_ = [
        ('status_bit_field_1', ctypes.c_uint32),
        ('status_bit_field_2', ctypes.c_uint32),
        ('time_hardware_1', ctypes.c_uint32),
        ('time_hardware_2', ctypes.c_uint32),
        ('time_system_1', ctypes.c_uint32),
        ('time_system_2', ctypes.c_uint32),
        ('time_stamp_hardware_id', ctypes.c_uint8),
        ('time_stamp_system_id', ctypes.c_uint8),
        ('network_id_1', ctypes.c_uint8),
        ('node_id', ctypes.c_uint8),
        ('protocol', ctypes.c_uint8),
        ('message_piece_id', ctypes.c_uint8),
        ('extra_data_ptr_enabled', ctypes.c_uint8),
        ('number_bytes_header', ctypes.c_uint8),
        ('number_bytes_data', ctypes.c_uint8),
        ('network_id_2', ctypes.c_uint8),
        ('description_id', ctypes.c_uint16),
        ('arb_id_or_header', ctypes.c_uint32),
        ('data', ctypes.c_uint8 * 8),
        ('status_bit_field_3', ctypes.c_uint32),
        ('status_bit_field_4', ctypes.c_uint32),
        ('extra_data_ptr', ctypes.c_uint32),
        ('misc_data', ctypes.c_uint8),
        ('reserved', ctypes.c_uint8 * 3),
    ]

    @classmethod
    def create(cls, base_time, clog_message):
        instance = cls()
        ctypes.memset(ctypes.addressof(instance), 0, ctypes.sizeof(instance))
        ctypes.memmove(ctypes.addressof(instance.data),
                       ctypes.addressof(clog_message.data),
                       ctypes.sizeof(instance.data))
        instance.status_bit_field_1 = 0x04000000  # standard message packet/whatever
        instance.arb_id_or_header = clog_message.can_id
        instance.set_time_hardware(base_time, clog_message.diff_time)
        instance.time_stamp_hardware_id = 9  # monkey-see-monkey-do from a real vsb file
        instance.time_stamp_system_id = 1  # monkey-see-monkey-do from a real vsb file
        instance.network_id_1 = 1  # monkey-see-monkey-do from a real vsb file
        instance.protocol = 1  # CAN protocol
        instance.number_bytes_header = 4
        instance.number_bytes_data = 8
        return instance

    def set_time_hardware(self, base_time, diff_time):
        # time stamps in vsb files are epoched from 1 Jan 2007
        epoch_20070101 = 1167609600
        # they are also stored in 1/40ths of a micro second
        my_time = ((base_time - epoch_20070101) * 1000 + diff_time) * 1000 * 40
        self.time_hardware_1 = my_time & 0xFFFFFFFF
        self.time_hardware_2 = my_time >> 32


def write_vsb_header(handle):
    """Write a version 0x0104 vsb header"""
    header = b'icsbin\x04\x01\x00\x00'
    handle.write(header)


def read_clog_header(handle):
    """Get the header instance from the clog file"""
    data = handle.read(ctypes.sizeof(ClogHeader))
    return ClogHeader.from_buffer_copy(data)


def process_file(input_file, output_file):
    """Read all the messages from a clog and write them out to a vbs"""
    clog_header = read_clog_header(input_file)
    base_time = clog_header.time_start
    write_vsb_header(output_file)

    blank = bytes(ctypes.sizeof(ClogMessage))
    while True:
        data = input_file.read(ctypes.sizeof(ClogMessage))
        if data == '' or data == blank or len(data) < ctypes.sizeof(ClogMessage) or data[:2] == bytes(2):
            break

        clog_message = ClogMessage.from_buffer_copy(data)
        vsb_message = VsbMessage.create(base_time, clog_message)
        output_file.write(vsb_message)


if __name__ == '__main__':
    input_names = sys.argv[1:]

    for input_name in input_names:
        output_name = input_name + '.vsb'
        with open(input_name, 'rb') as input_handle:
            with open(output_name, 'wb') as output_handle:
                process_file(input_handle, output_handle)
