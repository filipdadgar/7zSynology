#####
##### Script to run as task in synology for extracting zip files to a destination folder
#####

#!/bin/bash

SOURCE_DIR="/volume2/download/toicloud"
DESTINATION_DIR="/volume1/Photos"
LOG_FILE="/volume2/download/logfile.log"

{
    echo "Script started at $(date)"
    find "$SOURCE_DIR" -name '*.zip' -exec sh -c '
        for file do
            echo "Processing file $file at $(date)"
            7z x -aos -o'"$DESTINATION_DIR"' "$file"
            if [ "$?" -eq 0 ]; then
                echo "Successfully extracted $file at $(date)"
            else
                echo "Failed to extract $file at $(date)"
            fi
        done
    ' sh {} +
    echo "Script ended at $(date)"
} >> $LOG_FILE 2>&1
