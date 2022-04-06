#!/bin/bash

DEBUG=1 # Set it from 0 up to 4

# Prints debug messages where level are less or equal to $DEBUG
debug(){
    if [ "$1" -le $DEBUG ]
    then
        shift
        echo "--- DEBUG $*"
    fi
}

debug 1 'Debug message level 1'
debug 2 'Debug message level 2'
debug 3 'Debug message level 3'
debug 4 'Debug message level 4'