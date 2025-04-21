#!/bin/bash

## VARS BLOCK
# General vars
FILE_NAME="kustomization.yaml"
# FILE VARS


find_and_remove_file() {
    echo "The following file will be removed everytime it appears on the current route: ${FILE_NAME}"

    local file_list=$(find * -type f -name $FILE_NAME)
    for file in ${file_list[@]}; do
        rm $file
    done

    echo "File(s) was removed."
}

find_and_remove_file
