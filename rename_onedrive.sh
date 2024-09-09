#!/bin/bash

# Define the directory path
onedrive_dir="$HOME/Onedrive/"

# Function to rename files and directories
rename_items() {
    for item in "$1"/*; do
        if [ -e "$item" ]; then
            # Get the base name and directory name
            base_name=$(basename "$item")
            dir_name=$(dirname "$item")

            # Convert to lowercase and replace spaces and hyphens with underscores
            new_name=$(echo "$base_name" | tr '[:upper:]' '[:lower:]' | tr ' -' '__')

            # Rename the item if the new name is different
            if [ "$base_name" != "$new_name" ]; then
                mv "$item" "$dir_name/$new_name"
            fi

            # If the item is a directory, recursively rename its contents
            if [ -d "$dir_name/$new_name" ]; then
                rename_items "$dir_name/$new_name"
            fi
        fi
    done
}

# Check if the directory exists
if [ -d "$onedrive_dir" ]; then
    # Rename the contents of the directory
    rename_items "$onedrive_dir"
    echo "Renaming completed."
else
    echo "Directory $onedrive_dir does not exist."
fi
