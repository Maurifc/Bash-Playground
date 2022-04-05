#!/bin/bash
# list_user.sh
#
# List all system users
# (Basically reading /etc/passwd file)
#
#
#
# Mauri F Carmo, April 2022
#

##########
# Global #
##########
VERSION=0.1
USAGE_MESSAGE="\
Usage: $(basename $0) [ -V | -h ] 

-s  Sort user list
-V  Show script version
-h  Show help and exit\
"
#########
# Flags #
#########
sortList=0

# Process options
function checkForOptions(){
    # Exit if no options was passed
    if [ -z $1 ];
    then
        return;
    fi

    case "$1" in
        -V | --version)
            echo "$(basename $0) v$VERSION"
            exit 0;
        ;;
        -h | --help)
            echo "$USAGE_MESSAGE" # Use double quotes to echo line breaks
            exit 0;
        ;;
        -s | --sort)
            sortList=1
        ;;
        *)
            echo "Unknown options: \"$1\"" 
            exit 1;
        ;;
    esac
}

checkForOptions $@

########
# Main #
########

# Print users
users=$(cut -d : -f 1,5 /etc/passwd | tr : \\t | tr -d ,)

if [ "$sortList" == 1 ]
then
    users=$(echo "$users" | sort)
fi

echo "$users"