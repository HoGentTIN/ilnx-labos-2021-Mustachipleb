#!/bin/bash
# 8.
echo path?
read path

if [[ -f $path ]]; then
    if ! [[ -x $path ]]; then
        echo "making $path executable"
        chmod u+x $path
    fi
else
    echo "it do not be existing"
fi
