#!/bin/bash
user=$(cut -d ":" -f 1 /etc/passwd | sort)
for user in $user; do
    printf "%s\n" "$user"
done