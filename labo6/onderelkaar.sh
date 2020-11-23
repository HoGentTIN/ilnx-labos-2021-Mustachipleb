#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Geen argumenten opgegeven!"
    exit 1
fi

for arg in "$@"
do
    printf "%s\n" "$arg"
done
