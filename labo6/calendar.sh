#!/bin/bash
# 9.
months=("jan feb mar apr may jun jul aug sep oct nov dec")

if [[ ! " ${months[@]} " =~ " $1 " ]]; then
    echo wrong input
    exit 1
fi

if [ -n "$2" ]; then
    line=$2
else
    line=$(date +%Y)
fi

echo "$(cal $1 $2)"