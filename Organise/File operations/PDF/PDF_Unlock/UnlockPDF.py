import pikepdf
with pikepdf.open("file1.pdf") as pdf:
  num_pages = len(pdf.pages)
  del pdf.pages[-1]
  pdf.save("decrypted.pdf")

#import tabula
#tabula.read_pdf("decrypted.pdf", stream=True)

import PyPDF2
pdfFileObj=open("decrypted.pdf", "rb")
pdfReader=PyPDF2.PdfFileReader(pdfFileObj)
pdfReader.numPages
pageObj=pdfReader.getPage(0)
pageObj.extractText()
