#!/bin/bash

OBJECT_TO_COPY="/tmp"
DESTINATION_FOLDERS=$(find * -maxdepth 0 -type d)

for DEST in ${DESTINATION_FOLDERS[@]}; do
    cp -r $OBJECT_TO_COPY $DEST
done