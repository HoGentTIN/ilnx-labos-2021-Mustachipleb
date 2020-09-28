# Labo 8: complexere scripts

Als je gebruik maakt van andere bronnen (bv. blog-artikel of HOWTO die je op het Internet vond), voeg die dan toe aan het einde van dit document. Zo kan je het later makkelijk terug vinden.

Maak ter voorbereiding zeker de oefeningen in Linux Fundamentals (Paul Cobbaut) over dit onderwerp (pp. 97, 174 en 181).


## Scripts

Voor sommige van de opgaven zijn er unit tests voorzien die je een aanwijzing geven of je op de goede weg zit. De bedoeling is dat je de gevraagde scripts in de subdirectory `labo6` opslaat. Als je je in directory `labo6` bevindt, kan je de tests uitvoeren met:

```console
$ tests/runtests.sh
Installing ShellCheck. Please enter your sudo password!
[sudo] password for user: 
Last metadata expiration check performed 0:02:24 ago on Tue Oct 20 14:05:56 2015.
Dependencies resolved.

... [installatie ShellCheck en BATS]

Running test /home/user/scripts/tests/01-onderelkaar.bats
 ✗ Het script onderelkaar.sh moet bestaan
   (in test file tests/01-onderelkaar.bats, line 10)
     `[ -f "${script}" ]' failed
 ✗ Het script moet uitvoerbaar zijn
   (in test file tests/01-onderelkaar.bats, line 14)
     `[ -x "${script}" ]' failed

... [meer uitvoer van het testscript]
```

Indien nodig wordt bij het voor de eerste keer uitvoeren van het testscript het Unit-testframework voor Bash, [BATS](https://github.com/sstephenson/bats), geïnstalleerd en ook de statische analysetool [ShellCheck](https://www.shellcheck.net/).

De unit tests van de oefeningen worden in volgorde uitgevoerd. Zolang er nog fouten in een oefening gevonden zijn, worden de tests van de volgende nog niet uitgevoerd.

1. Schrijf een script `passphrase.sh` dat een willekeurige wachtwoordzin genereert zoals gesuggereerd door <http://xkcd.com/936/>. Gebruik een woordenlijst zoals `/usr/share/dict/words` (moet je mogelijks installeren). Opties en argumenten:
    - `passphrase.sh [-h|-?|--help]`: druk uitleg over het commando af en sluit af met exit-status 0. Eventuele andere opties en argumenten worden genegeerd.
    - `passphrase.sh [N] [WORDS]`
        - N = het aantal woorden in de wachtwoordzin (standaardwaarde = 4)
        - WORDS = het bestand dat de te gebruiken woordenlijst bevat (standaardwaarde = `/usr/share/dict/words`)
    - Sluit af met een passende foutboodschap (op stderr!) en exit-status als:
        - er meer dan twee parameters gegeven werden
        - WORDS niet bestaat of niet leesbaar is
    - Tip: met het commando `shuf` kan je de volgorde van lijnen tekst door elkaar schudden.
2. Schrijf een script om een backup te maken van de gegeven directory, meer bepaald een Tar-archief gecomprimeerd met bzip2.
    - Het archief krijgt als naam DIRECTORY-TIMESTAMP.tar.bzip2 met:
        - DIRECTORY = de naam van de directory waarvan je een backup maakt
        - TIMESTAMP = de huidige datum/tijd in het formaat JJJJMMDDUUMM
        - vb. “student-201312021825.tar.bz2” voor directory /home/student
    - Er wordt in dezelfde directory als het archief een log weggeschreven naar een bestand backup-TIMESTAMP.log van de uitvoer (zowel stdout als stderr) van het tar-commando.
    - Gebruik: `backup.sh [OPTIES] [DIR]`
    - Opties en argumenten:
        - `-h|-?|--help`: druk uitleg over het commando af en sluit af met exit-status 0. Eventuele andere opties en argumenten worden genegeerd.
        - `-d|--destination DIR`: de directory waar de backup naartoe geschreven moet worden. Standaardwaarde is `/tmp`
        - `DIR` de directory waarvan er een backup gemaakt moet worden. Standaardwaarde is de home-directory van de huidige gebruiker.
    - Sluit af met een passende foutboodschap (op stderr!) en exit-status als:
        - er teveel argumenten gegeven worden
        - de directory waarvan een backup gemaakt moet worden niet bestaat
        - de directory waar de backup naartoe geschreven moet worden niet bestaat

## Gebruikte bronnen
