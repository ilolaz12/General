
import os
import shutil
from PyPDF2 import PdfReader, PdfWriter
from ebooklib import epub
from ebooklib.epub import EpubBook
import subprocess

def scan_directory(directory, extensions):
    """
    Scan a directory and return a list of files with the given extensions.
    """
    files = []
    for root, _, filenames in os.walk(directory):
        for filename in filenames:
            if any(filename.lower().endswith(ext) for ext in extensions):
                files.append(os.path.join(root, filename))
    return files

def process_pdf(file_path):
    """
    Extract and clean metadata for a PDF file.
    """
    try:
        reader = PdfReader(file_path)
        writer = PdfWriter()

        # Extract metadata
        metadata = reader.metadata
        print(f"Original metadata for {file_path}: {metadata}")

        # Clean metadata
        cleaned_metadata = {}
        for key, value in metadata.items():
            if isinstance(value, str) and len(value) < 1000:  # Filter unusually long entries
                cleaned_metadata[key] = value

        # Write the new metadata to a new PDF
        for page in reader.pages:
            writer.add_page(page)
        writer.add_metadata(cleaned_metadata)

        backup_path = file_path + ".backup"
        shutil.copy(file_path, backup_path)  # Backup original
        with open(file_path, "wb") as f:
            writer.write(f)
        print(f"Metadata cleaned for {file_path}. Backup saved at {backup_path}.")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def process_epub(file_path):
    """
    Extract and clean metadata for an EPUB file.
    """
    try:
        book = epub.read_epub(file_path)
        metadata = book.get_metadata("DC", "*")
        print(f"Original metadata for {file_path}: {metadata}")

        # Clean metadata
        cleaned_metadata = []
        for meta in metadata:
            key, value, _ = meta
            if isinstance(value, str) and len(value) < 1000:  # Filter unusually long entries
                cleaned_metadata.append((key, value, {}))

        # Set cleaned metadata
        book.set_metadata("DC", cleaned_metadata)

        backup_path = file_path + ".backup"
        shutil.copy(file_path, backup_path)  # Backup original
        epub.write_epub(file_path, book)
        print(f"Metadata cleaned for {file_path}. Backup saved at {backup_path}.")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def process_other_files_with_exiftool(file_path):
    """
    Use ExifTool to clean metadata for other file types.
    """
    try:
        backup_path = file_path + ".backup"
        shutil.copy(file_path, backup_path)  # Backup original

        # Clean metadata using exiftool
        subprocess.run(["exiftool", "-all=", "-overwrite_original", file_path], check=True)
        print(f"Metadata cleaned for {file_path}. Backup saved at {backup_path}.")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    directory = input("Enter the directory containing your books: ")
    extensions = [".pdf", ".epub", ".mobi"]
    files = scan_directory(directory, extensions)

    for file_path in files:
        if file_path.lower().endswith(".pdf"):
            process_pdf(file_path)
        elif file_path.lower().endswith(".epub"):
            process_epub(file_path)
        else:
            process_other_files_with_exiftool(file_path)

if __name__ == "__main__":
    main()