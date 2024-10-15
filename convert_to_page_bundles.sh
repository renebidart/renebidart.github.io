#!/bin/bash

# Base directory
BASE_DIR="content/post"
DRY_RUN=false

# Check for dry run flag
if [ "$1" == "--dry-run" ]; then
    DRY_RUN=true
    echo "Performing dry run. No files will be modified."
fi

# Function to execute or echo a command
execute_or_echo() {
    if [ "$DRY_RUN" = true ]; then
        echo "Would execute: $1"
    else
        eval "$1"
    fi
}

# Iterate over each Markdown file in content/post/
for mdfile in "$BASE_DIR"/*.md; do
    # Skip if not a file
    [ -f "$mdfile" ] || continue

    # Get the filename without extension
    filename=$(basename "$mdfile" .md)
    
    # Define the new directory path
    new_dir="$BASE_DIR/$filename"
    
    echo "Processing: $mdfile"

    # Create the new directory
    execute_or_echo "mkdir -p \"$new_dir\""
    
    # Move the Markdown file to index.md within the new directory
    execute_or_echo "mv \"$mdfile\" \"$new_dir/index.md\""
    
    # Move all image files referenced in the Markdown to the new directory
    while IFS= read -r line; do
        if [[ $line =~ \!\[.*\]\((.*)\) ]]; then
            image_path="${BASH_REMATCH[1]}"
            if [[ $image_path == ../* ]]; then
                image_name=$(basename "$image_path")
                execute_or_echo "mv \"$BASE_DIR/${image_path#../}\" \"$new_dir/$image_name\""
            fi
        fi
    done < "$mdfile"
    
    # Update image paths in index.md
    # Replace ![alt](../image.png) with ![alt](image.png)
    if [ "$DRY_RUN" = true ]; then
        echo "Would update image paths in $new_dir/index.md"
    else
        sed -i.bak 's/!\(\[[^]]*\]\)(\.\.\/\([^)]*\))/![\1](\2)/g' "$new_dir/index.md"
        rm "$new_dir/index.md.bak"
    fi
    
    echo "Converted $mdfile to $new_dir/index.md"
    echo "----------------------------------------"
done

echo "All Markdown files have been processed."