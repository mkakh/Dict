#!/usr/bin/env bash

set -eu
DICT_FILE="~/.config/dict/dict.csv"
mkdir -p "~/.config/dict"

if [ $# -lt 2 ]; then
    echo "Usage: $0 [search|add|delete] word"
    exit 1
fi

if [ $1 = "add" ] || [ $1 = "a" ]; then
    if [ $# -eq 3 ]; then
        DEFINITION=$3
    else
        echo "What is the definition?"
        printf "> " 
        read DEFINITION 
    fi
    printf "%s,%s\n" "$2" "$DEFINITION" >> $DICT_FILE
elif [ $1 = "search" ] || [ $1 = "s" ]; then
    grep -w "$2" $DICT_FILE
elif [ $1 = "delete" ] || [ $1 = "d" ]; then
    sed "/^$2,.*$/d" -i $DICT_FILE
else
    echo "Usage: $0 [search|add|delete] word"
    exit 1
fi
