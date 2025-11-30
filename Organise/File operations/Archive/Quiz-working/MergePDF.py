import PyPDF2
import csv
import pandas as pd
import webbrowser
import webbot
from webbot import Browser


mergeFile = PyPDF2.PdfFileMerger()

mergeFile.append(PyPDF2.PdfFileReader('1.pdf', 'rb'))
mergeFile.append(PyPDF2.PdfFileReader('2.pdf', 'rb'))
mergeFile.append(PyPDF2.PdfFileReader('3.pdf', 'rb'))
#mergeFile.append(PyPDF2.PdfFileReader('4.pdf', 'rb'))
#mergeFile.append(PyPDF2.PdfFileReader('5.pdf', 'rb'))

mergeFile.write("NewMergedFile.pdf")
