"""Program to convert Tritium .csv CAN log files to Vehicle Spy binary files"""
import csv
import ctypes
import struct
from datetime import datetime
import sys
try:
    droppedFile = sys.argv[1]
except IndexError:
    print("No file dropped")

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
    def create(cls, message_time_us, can_id, can_data):
        instance = cls()
        ctypes.memset(ctypes.addressof(instance), 0, ctypes.sizeof(instance))
        ctypes.memmove(ctypes.addressof(instance.data), can_data, ctypes.sizeof(instance.data))
        instance.status_bit_field_1 = 0x04000000  # standard message packet/whatever
        instance.arb_id_or_header = can_id
        instance.set_time_hardware(message_time_us)
        instance.time_stamp_hardware_id = 9  # monkey-see-monkey-do from a real vsb file
        instance.time_stamp_system_id = 1  # monkey-see-monkey-do from a real vsb file
        instance.network_id_1 = 1  # monkey-see-monkey-do from a real vsb file
        instance.protocol = 1  # CAN protocol
        instance.number_bytes_header = 4
        instance.number_bytes_data = 8
        return instance

    def set_time_hardware(self, message_time_us):
        # they are also stored in 1/40ths of a micro second
        my_time = message_time_us * 40
        self.time_hardware_1 = my_time & 0xFFFFFFFF
        self.time_hardware_2 = my_time >> 32


def write_vsb_header(handle):
    """Write a version 0x0104 vsb header"""
    header = b'icsbin\x04\x01\x00\x00'
    handle.write(header)


def extract_message(csv_row):
    """Get and convert the data from a csv row"""
    dt = datetime.strptime(csv_row[0].strip(), "%H:%M:%S.%f")
    base = datetime(1900, 1, 1)
    message_time_us = int((dt - base).total_seconds() * 1000 * 1000)
    can_id = int(csv_row[2].strip(), 16)
    # clean off the spaces, and the "0x" at the start, convert to bytes, then reverse them
    can_data = bytes.fromhex(csv_row[4].strip()[2:])[::-1]
    return {'message_time_us': message_time_us, 'can_id': can_id, 'can_data': can_data}


def process_file(input_reader, output_file):
    """Read all the messages from a clog and write them out to a vbs"""
    write_vsb_header(output_file)

    next(input_reader, None)  # skip the .csv header
    for row in input_reader:
        message = extract_message(row)
        vsb_message = VsbMessage.create(**message)
        output_file.write(vsb_message)


if __name__ == '__main__':
    input_names = sys.argv[1:]

    for input_name in input_names:
        output_name = input_name + '.vsb'
        with open(input_name, newline='') as input_handle:
            input_reader = csv.reader(input_handle)
            with open(output_name, 'wb') as output_handle:
                process_file(input_reader, output_handle)
