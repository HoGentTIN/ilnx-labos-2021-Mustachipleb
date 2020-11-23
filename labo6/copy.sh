#!/bin/bash
# 6. Dit script zal een bestand kopiëren.
# Bron en doel worden aan de gebruiker gevraagd.
# Test of het doelbestand bestaat.
# Indien wel, wordt het script afgebroken.
# (opm. geen unit tests)
echo Path to the file you\'d like to copy?
read srcpath
echo Path to the destination folder?
read destpath

if ! [[ -f "$destpath/$(basename $srcpath)" ]]; then
    cp $srcpath $destpath
else
    exit 1
fi