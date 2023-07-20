#!/bin/bash

## VARS BLOCK
# General vars
ROUTE="/home/dani_workstation/itnow_git/icp_projects/batchicp/k8s/ocp"

# FILE VARS
FILE_NEW_NAME="ocp"
INIT_VAUE="all"
FINAL_VALUE="infra"


modify_file_name() {
    echo "Change file names on: $ROUTE"

    local file_list=$(find * -type f -name "*.yaml")
    for file in ${file_list[@]}; do
        mv $file $FILE_NEW_NAME-$file
    done

    echo "File names changed."
}

modify_file_content() {
    echo "Change content file $INIT_VAUE for $FINAL_VALUE"

    local file_list=$(find * -type f -name "*.yaml")
    for file in ${file_list[@]}; do
        sed -i "s/$INIT_VAUE/$FINAL_VALUE/g" $file
    done

    echo "File names changed."
}

modify_file_name
modify_file_content