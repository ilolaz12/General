import zipfile
import os

# Define the folder where your .zip files are located
folder_path = r'G:\My Drive\Study\UQS\CSC2402 - Programming 3 Object Orientation\Code'


# List all files in the folder
file_list = os.listdir(folder_path)

# Loop through the files and extract .zip files
for file_name in file_list:
    if file_name.endswith('.zip'):
        # Construct the full path to the .zip file
        zip_file_path = os.path.join(folder_path, file_name)

        # Create a directory to extract the contents (optional)
        extraction_folder = os.path.splitext(zip_file_path)[0]
        os.makedirs(extraction_folder, exist_ok=True)

        # Extract the .zip file
        with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(extraction_folder)

print("Extraction complete.")
