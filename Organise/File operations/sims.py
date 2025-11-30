import os
import zipfile
import shutil

# Set your directories here
source_directory = 'G:/My Drive/Code/Organise/File operations/SimMods'
target_directory = 'C:/Users/ilo_l/OneDrive/Документы/Electronic Arts/The Sims 4/Mods'

if not os.path.exists(target_directory):
    os.makedirs(target_directory)

for item in os.listdir(source_directory):
    if item.endswith('.zip'):
        zip_path = os.path.join(source_directory, item)
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            for file in zip_ref.namelist():
                if file.endswith('.package'):
                    extracted_path = os.path.join(source_directory, file)
                    target_path = os.path.join(target_directory, os.path.basename(file))

                    # Check if file already exists in target directory
                    if not os.path.exists(target_path):
                        zip_ref.extract(file, source_directory)
                        shutil.move(extracted_path, target_path)
                        
                        # Remove the folder if it's now empty
                        folder_path = os.path.dirname(extracted_path)
                        if not os.listdir(folder_path):
                            os.rmdir(folder_path)
                    else:
                        print(f"Skipped existing file: {file}")

        # Delete the zip file
        os.remove(zip_path)

print("Extraction, moving and cleanup completed.")