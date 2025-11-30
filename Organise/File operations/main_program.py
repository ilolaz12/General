import file_operations


# Paths to the folders to compare
folder1_path = 'path/to/folder1'
folder2_path = 'path/to/folder2'

'''
# Prompt the user to input the paths
folder1_path = input("Enter the path to the first folder: ")
folder2_path = input("Enter the path to the second folder: ")
'''


# Use the function from the module
file_operations.compare_and_delete(folder1_path, folder2_path)
