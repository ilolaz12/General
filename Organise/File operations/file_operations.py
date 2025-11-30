import os
import shutil

def get_file_paths(directory):
    """Get a list of absolute file paths in a directory."""
    file_paths = []
    for root, _, files in os.walk(directory):
        for file in files:
            file_paths.append(os.path.join(root, file))
    return file_paths

def compare_and_delete(folder1, folder2):
    """Delete files from the larger folder that are present in the smaller one."""
    folder1_files = set(get_file_paths(folder1))
    folder2_files = set(get_file_paths(folder2))

    # Determine which folder is larger
    if len(folder1_files) > len(folder2_files):
        larger_folder, smaller_folder = folder1, folder2_files
    else:
        larger_folder, smaller_folder = folder2, folder1_files

    # Delete common files from the larger folder
    for file_path in larger_folder:
        relative_path = os.path.relpath(file_path, larger_folder)
        if os.path.join(smaller_folder, relative_path) in smaller_folder:
            os.remove(file_path)
            print(f"Deleted: {file_path}")


# Specify the paths to the two folders
folder1_path = 'C:/Users/ilo_l/OneDrive/Документы/Electronic Arts/The Sims 4/Mods'
folder2_path = 'C:/Users/ilo_l/OneDrive/Документы/Electronic Arts/The Sims 4/Mods/New folder'

compare_and_delete(folder1_path, folder2_path)


