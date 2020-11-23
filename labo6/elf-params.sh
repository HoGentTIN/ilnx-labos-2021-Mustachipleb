#!/bin/bash

if [[ $# -eq 0 ]] ; then
    exit 1
fi

numargs=$(( $# < 11 ? $# : 11 ))

for (( i=1; i<=numargs; i++)) ; do
    printf "%s\n" "$1"
    shift
done