#!/bin/bash

cd ~/Downloads

# enable advanced pattern matching
shopt -s extglob
shopt -s dotglob

# create directory if it does not exist
mkdir -p ~/Downloads/trash

# Function to find a non-existing name for the file or directory
find_non_existing_name() {
    local name="$1"
    local suffix=1
    local new_name="$name"

    while [[ -e "$new_name" ]]; do
        new_name="${name}_${suffix}"
        ((suffix++))
    done

    echo "$new_name"
}

# Move files to trash
for item in !(trash); do
    if [[ -e "$item" ]]; then
        new_item=$(find_non_existing_name "trash/${item##*/}")
        mv "$item" "$new_item"
    fi
done

# disable advanced pattern matching
shopt -u dotglob
shopt -u extglob
