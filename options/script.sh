#!/bin/bash

USAGE_MESSAGE="\
Usage: $(basename $0) [ -h | -V ]"

case "$1" in
    -h | --help )
        echo "$USAGE_MESSAGE"
        exit 0
    ;;
    -V | --version)
        echo $(basename $0)
        echo "Version 1.0"
        exit 0
    ;;
    *)
        if [ -n "$1" ];
        then
            echo "Unknown option \"$1\"" 
            exit 1
        fi
    ;;
esac


############
echo Script running...