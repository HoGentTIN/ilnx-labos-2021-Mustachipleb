#!/bin/bash
set -- $(date)

echo "$#"
while (( "$#" )); do
    echo "$1"
    shift
done