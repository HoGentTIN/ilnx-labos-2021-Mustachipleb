#!/bin/bash
# 7. Sorteer de inhoud van een bestand (arg1) en toon de laatste regels (aantal regels = arg2).
# Indien argument 1 ontbreekt, melding geven en afbreken.
# Indien argument 2 ontbreekt neemt men 20 als default waarde.
# Om te testen maak je een bestand aan met alle letters van het alfabet, in de volgorde van je toetsenbord.
# (opm. geen unit tests)
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

file=$1

if [ -n "$2" ]; then
    line=$2
else
    line=20
fi

echo $(sort $file | tail -n $line)