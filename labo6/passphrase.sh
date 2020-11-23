#!/bin/bash
# 10.
helpargs=("-h -? --help")

generate_passphrase() {
    result=$(shuf $dir | head -$n)
    for word in $result; do
        formatted="$formatted$word"
    done
    echo $formatted
}

if [[ " ${helpargs[@]} " =~ " $1 " ]]; then
    echo '- `passphrase.sh [N] [WORDS]`'
    echo '- N = het aantal woorden in de wachtwoordzin (standaardwaarde = 4)'
    echo '- WORDS = het bestand dat de te gebruiken woordenlijst bevat (standaardwaarde = `/usr/share/dict/words`)'
elif [[ $# > 2 ]]; then
    echo 'Meer dan 2 argumenten.'
    exit 1
else
    if [ -n "$1" ]; then
        n=$1
    else
        n=4
    fi
    
    if [ -n "$2" ]; then
        if [ -f "$2" ]; then
            dir=$2
        else
            echo 'Woorden bestand niet gevonden'
            exit 1
        fi
    else
        dir="/usr/share/dict/words"
    fi

    echo $(generate_passphrase $n $dir)
fi