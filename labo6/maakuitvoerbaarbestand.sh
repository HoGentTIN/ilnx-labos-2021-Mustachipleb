#!/bin/bash
# 5. Vraag aan de gebruiker van dit script een naam voor een bestand,
# schrijf dit vervolgens weg en zorg ervoor dat het bestand uitvoerbaar is.
# (opm. geen unit tests)
echo File name?
read name
touch ${name}.sh
chmod u+x ${name}.sh