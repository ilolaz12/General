#import PyPDF2
#import csv
#import pandas as pd
#import webbrowser
#import webbot
#from webbot import Browser
#import PdfMerger
from PyPDF4 import PdfFileMerger
import os,argparse


mergeFile = PdfFileMerger.PdfFileMerger()

mergeFile.append(PdfFileMerger.PdfFileReader('1.pdf', 'rb'))
mergeFile.append(PdfFileMerger.PdfFileReader('2.pdf', 'rb'))
mergeFile.append(PdfFileMerger.PdfFileReader('3.pdf', 'rb'))
#mergeFile.append(PdfFileMerger.PdfFileReader('4.pdf', 'rb'))
#mergeFile.append(PdfFileMerger.PdfFileReader('5.pdf', 'rb'))

mergeFile.write("NewMergedFile.pdf")
