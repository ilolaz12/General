#!/usr/local/bin/python3

# convert .clog format to .csv format

import sys, os, argparse, struct, time, base64
import csv
import canProcess


HEADER_SIZE         = 16
LOG_DATA_SIZE       = 16
CHARGE_STATE_SIZE   = 16
NODE_STATE_SIZE     = 64
DATA_TIME_SPACE     = 256

headers = ['Recv time',' Packet num',' ID','flags',' data']
float_headers = ['Recv time',' Packet num',' ID',' flags',' data', ' float[1]', ' float[0]']

def write_csvData(f_csv, data):
    f_csv.writerow(data)
    pass

def error_process(errMsg):
    if errMsg == 'FileEmpty':
        print('File Empty, no data existed')
    elif errMsg == 'NoFile':
        print("File not found")
    pass


def format_csvData(data):
    timeStr, numStr, IDStr, dataStr = data
    flags = 0
    timeStr = timeStr[11:]
    tup = (timeStr, numStr, IDStr, flags, dataStr)
    return tup

def format_csvFloat(data, floatStr1, floatStr0):
    timeStr, numStr, IDStr, dataStr = data
    flags = 0
    timeStr = timeStr[11:]
    tup = (timeStr, numStr, IDStr, flags, dataStr, floatStr1, floatStr0)
    return tup

# Process command line options
opt = argparse.ArgumentParser(prog= 'logToCsv', description= 'CAN log to Csv tool: change clog format into csv format')

opt.add_argument('-c', '--compress', action = "store_true", default= False,
                 help='compress format, output without decode data')
opt.add_argument('-v', '--vmachine', action = "store_true", default= False,
                 help='use -v when data are collected on virtual machine')
opt.add_argument('file', nargs='?', default='chad.clog',
                 help='.clog file of the can log. should reside in the current directory')

args = opt.parse_args()

if args.file:
    args.file = args.file[:-5]
else:
    error_process('NoFile')

if args.vmachine:
    data_revert = 'false'
    print('Use Virtual machine mode')
else:
    data_revert = 'true'

inputPath = os.getcwd() + '/' + args.file + '.clog'
csvPath = os.getcwd() + '/' + args.file + '.csv'

if os.path.exists(inputPath):
    inputSize = os.path.getsize(inputPath)
    inputData = open(inputPath, 'rb')
    if (canProcess.check_CRC(inputData, inputSize)):
        print('CRC check passed, log data correct')
    else:
        print('CRC check fail')

    csv_file = open(csvPath, 'w', newline='')
    f_csv = csv.writer(csv_file)
    if args.compress:
        f_csv.writerow(headers)
    else:
        f_csv.writerow(float_headers)

    inputData.seek(0)
    header_data = inputData.read(HEADER_SIZE)
    logNum = 0
    if header_data:
        logVersion, logFlags, logNum, logSec, logCrc = canProcess.proc_header(header_data)
    else:
        error_process('FileEmpty')

    if logNum > 0:
        convNum = logNum

        # node state data position
        statPos = LOG_DATA_SIZE*logSec+16

        logDate = time.gmtime(logSec)

        curMilis = logSec*1000

        data_continuity = 0
        #print can data
        for i in range(0, convNum):
            candata = inputData.read(LOG_DATA_SIZE)
            data = canProcess.proc_candata(candata, curMilis, i + 1, data_revert)
            if args.compress:
                data = canProcess.proc_candata(candata, curMilis, i + 1, data_revert)
                data = format_csvData(data)
            else:
                data = canProcess.proc_candata(candata, curMilis, i + 1, data_revert)
                floatStr1, floatStr0 = canProcess.proc_convFloat(candata)
                data = format_csvFloat(data, floatStr1, floatStr0)

            write_csvData(f_csv, data)
            if i > 0:
                ret = canProcess.check_continuity(candataRef, candata, DATA_TIME_SPACE)
                if ret == 'true':
                    data_continuity += 1
                    print("Warning: Found Data Continuity Problem, Log Num: %d" %(i+1))
                pass
            candataRef = candata
            pass

        # print general status
        print ('Conversion Success')
        print ('Output File: %s' % (args.file + '.csv'), end= ', ')
        print('Total Log Number: %d' % logNum, end=', ')
        print(time.strftime("Log file time: %Y-%m-%d %H:%M:%S", logDate))

        # print data continuity check
        if data_continuity > 0:
            print('Found data Continuity Problem, number = %d' % data_continuity)
        pass
    else:
        error_process('FileEmpty')
        pass

    inputData.close()
    csv_file.close()
    pass
else:
    error_process('NoFile')
    pass
