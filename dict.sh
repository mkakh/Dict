#!/usr/bin/env bash

set -eu
DICT_FILE="$HOME/.config/dict/dict.csv"
mkdir -p "$HOME/.config/dict"

ARGC=$#

function check_argc() {
    if [ $ARGC -lt $1 ]; then
        echo "Usage: $0 [all|reset|search|add|delete] word"
        exit 1
    fi
}
    
check_argc 1

if [ $1 = "all" ] || [ $1 = "show" ]; then
    check_argc 1
    sort -d $DICT_FILE
elif [ $1 = "reset" ]; then
    check_argc 1
    echo "Are you sure to delete the dictionary file? [y/N]"
    read REPLY
    if [[ $REPLY =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        rm $DICT_FILE
    fi
elif [ $1 = "add" ] || [ $1 = "a" ]; then
    check_argc 2
    if [ $# -eq 3 ]; then
        DEFINITION=$3
    else
        echo "What is the definition?"
        printf "> " 
        read DEFINITION 
    fi
    printf "%s,%s\n" "$2" "$DEFINITION" >> $DICT_FILE
elif [ $1 = "search" ] || [ $1 = "s" ]; then
    check_argc 2
    grep -E "^$2,.*$" $DICT_FILE
elif [ $1 = "delete" ] || [ $1 = "d" ]; then
    check_argc 2
    sed "/^$2,.*$/d" -i $DICT_FILE
else
    check_argc 256
fi
