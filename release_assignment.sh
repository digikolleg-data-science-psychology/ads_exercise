#!/bin/bash

# Usage: ./release_assignment.sh <assignment>

# Check for required arguments
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <assignment>"
    exit 1
fi

replace_word_in_file() {
    local file="$1"
    local old_word="$2"
    local new_word="$3"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS (BSD sed)
        sed -i '' "s/${old_word}/${new_word}/g" "$file"
    else
        # Linux (GNU sed)
        sed -i "s/${old_word}/${new_word}/g" "$file"
    fi
}

ASSIGNMENT="$1"

# get assignment number (first digit in the assignment name)
ASSIGNMENT_NO=$(echo "$ASSIGNMENT" | grep -o '[0-9]\+')

echo "Releasing assignment '$ASSIGNMENT'. Assignment number: $ASSIGNMENT_NO."

cd "course_directory/ads_exercise" || {
    echo "Error: Directory 'course_directory/ads_exercise' not found!"
    exit 1
}

# use nbgrader to release the assignment
nbgrader generate_assignment "$ASSIGNMENT"

cd ..

# use abc-classroom to create the template
abc-new-template "$ASSIGNMENT" --github

# use gh to edit the repo
cd "template_repos/$ASSIGNMENT-template" || {
    echo "Error: Directory 'template_repos/$ASSIGNMENT' not found!"
    exit 1
}

gh repo edit --accept-visibility-change-consequences --visibility public --template

# file name is the same as assignment name with - replace by _
ASSIGNMENT_FILE_NAME="${ASSIGNMENT//-/_}"

# replace all occurrences of REPLACE_NO with the assignment number
replace_word_in_file "README.md" "REPLACE_NO" "$ASSIGNMENT_NO"

# replace all occurrences of REPLACE_FILE_NAME with the assignment file name
replace_word_in_file "README.md" "REPLACE_FILE_NAME" "$ASSIGNMENT_FILE_NAME"

# git add commit and push
git add README.md

git commit -m "Release assignment $ASSIGNMENT_NO"

git push origin main

# change directory to the course directory
cd ../..

echo "Assignment '$ASSIGNMENT' released successfully."
