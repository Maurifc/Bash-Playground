#!/bin/bash
# list_user.sh
#
# List all system users
# (Basically reading /etc/passwd file)
#
# Version 0.3.1: Add -d <delimiter> option
#
# Version 0.2.1: Refactoring to improve readability
#
# Version 0.2: Add -r, --reverse, -u and --uppercase
#   Add support to multi options
#
# Mauri F Carmo, April 2022
#
set -e

##########
# Global #
##########
VERSION=0.3.1
USAGE_MESSAGE="\
Usage: $(basename $0) [ -V | -h | -u | -d <delimiter> | -V | -h ] 

-s, --sort          Print user list in alphatical order
-r, --reverse       Print list in reverse order
-u, --uppercase     Print list in uppercase characters
-d, --delimiter     Print list in uppercase characters
-V, --version       Show script version
-h, --help          Show help and exit\
"
#########
# Flags #
#########
sortList=0
reverseOrder=0
uppercase=0
delimiter="\\t"

# Process options
function checkForOptions() {
    # Run until $1 be null / empty
    while [ ! -z "$1" ]; do
        case "$1" in
        -V | --version)
            echo "$(basename $0) v$VERSION"
            exit 0
            ;;
        -h | --help)
            echo "$USAGE_MESSAGE" # Use double quotes to echo line breaks
            exit 0
            ;;
        -s | --sort) sortList=1         ;;
        -r | --reverse) reverseOrder=1  ;;
        -u | --uppercase) uppercase=1   ;;
        -d | --delimiter ) 
            shift # Shift arguments to get new delimiter
            delimiter=$1

            if [ -z $delimiter ]
            then
                echo "Missing argument for -d option"
                exit 1
            fi
            ;;
        *)
            echo "Unknown options: \"$1\""
            exit 1
            ;;
        esac

        shift # Move $2 to $1, interating through all options user passed
    done
}

checkForOptions $@

########
# Main #
########

# Print users
users=$(cut -d : -f 1,5 /etc/passwd | tr : "$delimiter" | tr -d ,)

# if sortList == 1... 
test "$sortList" = 1 && users=$(echo "$users" | sort)

test "$reverseOrder" = 1 && users=$(echo "$users" | tac)

test "$uppercase" = 1 && users=$(echo "$users" | tr a-z A-Z)

# Finally print user list
echo "$users"
