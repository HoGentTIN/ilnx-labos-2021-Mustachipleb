# Labo 2: Linux leren kennen

## Hulp zoeken

1. Hoe vraag je op de command-line documentatie op voor het *commando* `passwd`?

    ```
    $ man passwd
    UITVOER
    ```

2. Hoe vraag je documentatie op voor het *configuratiebestand* `/etc/passwd`?

    ```
    $ man 5 passwd
    UITVOER
    ```

3. Hoe vraag je een lijst op van alle documentatie die de string `passwd` bevat?

    ```
    $ man -k passwd
    UITVOER
    ```

## Werken op de command-line

1. Wat is de huidige datum en uur?

    ```
    $ date
    Mon 28 Sep 11:25:23 CEST 2020
    ```

2. Wat is de huidige directory?

    ```
    $ pwd
    /home/mustachio
    ```

3. Toon de inhoud van de huidige directory. De uitvoer zou er ongeveer zo moeten uit zien:

    ```
    $ ls
    Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
    ```

4. Toon de inhoud van de huidige directory, maar toon voor elk bestand meer informatie en ook "verborgen" bestanden.

    ```
    $ ls -l
    total 96
    drwx------. 14 student student 4096 Sep 24 09:14 .
    drwxr-xr-x.  3 root    root    4096 Sep 20 13:46 ..
    -rw-------.  1 student student  146 Sep 20 14:06 .bash_history
    -rw-r--r--.  1 student student   18 Mar 11  2013 .bash_logout
    -rw-r--r--.  1 student student  193 Mar 11  2013 .bash_profile
    -rw-r--r--.  1 student student  124 Mar 11  2013 .bashrc
    drwx------.  8 student student 4096 Sep 20 13:54 .cache
    drwxr-xr-x. 16 student student 4096 Sep 20 13:55 .config
    drwxr-xr-x.  2 student student 4096 Sep 20 13:53 Desktop
    drwxr-xr-x.  2 student student 4096 Sep 20 13:53 Documents
    drwxr-xr-x.  2 student student 4096 Sep 20 13:53 Downloads
    [...]
    ```

5. Toon de inhoud van de hoofddirectory van het Linux-systeem, ook vaak de root-directory genoemd. Geef een uitgebreide listing zoals in de vorige vraag, maar *zonder* verborgen bestanden.

    ```
    $ ls -l /
    UITVOER
    ```

6. Wat betekenen volgende elementen van de uitvoer hierboven?
    - 1e kolom (bv. `drwxr-xr-x.`): Read & write permission
    - 2e kolom (getal): ...
    - 3e kolom (bv. `root`, `student`): Owner
    - 4e kolom (bv. `root`): Group owner
    - 5e kolom (getal): Size (directories always show as 4096)
    - 6e - 8e kolom (datum): Date modified
    - de aanduiding `->` (bv. `bin -> usr/bin`): Symbolic link aka. shortcut
7. Hoe kan je commando's die je voordien uitgevoerd hebt terug ophalen (de "commandogeschiedenis")?

    ```
    $ history
        1  sudo dnf upgrade -y
        2  sudo nano
        3  history
    ```

## De plaats van bestanden op een Linux-systeem

Vul de tabel hieronder aan. In de linkerkolom vind je de namen van een directory, in de rechter het soort bestanden dat er in thuis hoort.

| Directory                         | Inhoud                                                   |
| :---                              | :---                                                     |
| `/bin`, `/usr/bin`                | Essentiele uitvoerbare bestanden                         |
| `/sbin`                           | Uitvoerbare bestanden voor systeembeheertaken            |
| `/var`                            | Bestanden die variabel zijn in grootte                   |
| `/tmp`                            | Tijdelijke bestanden                                     |
| `/opt`, `/usr/local`              | Programma's                                              |
| `/root`                           | Home-directory van de `root` gebruiker                   |
| `/home/student`                   | Home-directory van de gebruiker `student`                |
| `/usr/local/man`                  | De inhoud van de man-pages                               |
| `/usr/local/doc`                  | Andere documentatie                                      |
| `/lib`, `/usr/lib`, `lib64`, enz. | Nodige libraries om te booten                            |
| `/media`                          | De inhoud van de installatie-cd voor Guest Additions(\*) |
| `/dev`                            | Bestanden van toestellen                                 |
| `/proc`                           | Procesinformatie                                         |
| `/etc`                            | Systeemconfiguratiebestanden                             |

(*) Je kan het insteken van de cd simuleren in het VirtualBox-venster van je VM in het menu "Devices" > "Insert Guest Additions CD image..." (of het Nederlandstalige equivalent).


## Werken met bestanden en directories

Om het verschil tussen een bestand en directory te verduidelijken, wordt in wat volgt de naam van een directory telkens afgesloten met “/”.

### Directories

Open eerst een terminalvenster, start de oefening vanuit je eigen home-directory. Ga enkel naar een andere directory als dat expliciet gevraagd wordt. Geef telkens de gevraagde commando's niet alleen om de taak uit te voeren, maar ook om te testen of dit correct gebeurd is.

In deze oefening leer je onderscheid maken tussen *relatieve* en *absolute paden*. Een *absoluut* pad begint altijd met een `/`, wat overeenkomt met de root-directory. Een *relatief* pad geldt vanaf de huidige directory.

1. Blijf in je home-directory en maak van hieruit een directory `tijdelijk/` aan onder `/tmp/`

    ```
    $ mkdir tijdelijk
    $ mv tijdelijk /tmp/
    ```

2. Verwijder deze directory meteen

    ```
    $ rmdir /tmp/tijdelijk
    ```

3. Maak onder je home-directory een submap aan met de naam `linux/`

    ```
    $ mkdir linux
    ```

4. Ga naar deze directory

    ```
    $ cd linux
    ```

5. Maak met één commando de subdirectory `a/b/` aan onder `linux/`. Als je nadien het commando `tree` geeft, moet je de gegeven uitvoer zien.

    ```
    $ mkdir -p a/b/
    $ tree
    .
    └── a
        └── b
    2 directories, 0 files
    ```

6. Verwijder directory `b/` en daarna `a/` (in twee commando's)

    ```
    $ rmdir a/b
    $ rmdir a
    ```

7. Maak met één commando deze directorystructuur aan.

    ```
    $ mkdir -p {c/d/,c/e/}
    $ tree
    .
    └── c
        ├── d
        └── e
    3 directories, 0 files
    ```

8. Verwijder in één commando de directory `c/` en alle onderliggende

    ```
    $ rmdir c/d/ c/e/ c
    ```

9. Maak met één commando deze directorystructuur aan. Het is de bedoeling de opdrachtregel zo kort mogelijk te maken, dus niet alle directories apart opgeven!

    ```
    $ mkdir -p {f/g/i,f/h/i}
    $ tree
    .
    └── f
        ├── g
        │   └── i
        └── h
            └── i

    5 directories, 0 files
    ```

Behoud deze directorystructuur voor de volgende oefeningen over bestanden.

### Bestanden

1. Maak een leeg bestand aan met de naam `file1`

    ```
    $ touch file1
    ```

2. Maak een *verborgen* bestand aan met de naam `hidden`. Verborgen betekent dat je het niet kan zien met een "gewone" `ls`, maar wel met de gepaste optie.

    ```
    $ touch .hidden
    ```

3. Tik volgend commando in, leg uit wat er hier precies gebeurt, wat het effect is.

    ```
    $ echo hello world > file2
    ```

    Schrijft "hello world" in een bestand genaamd file2.

4. Toon de inhoud van `file2`

    ```
    $ cat file2
    ```

5. Kopieer `file1` naar een nieuw bestand `file3` in de huidige directory

    ```
    $ cp file1 file3
    ```

6. Kopieer `file1` naar de directory `f/` (die zou je nog moeten hebben van vorige oefening)

    ```
    $ cp file1 f/
    ```

7. Kopieer `file1` en file2 in één keer naar `f/g/`. Je zou de gegeven situatie moeten krijgen.

    ```
    $ cp file{1,2} f/g/
    $ tree
    .
    ├── f
    │   ├── file1
    │   ├── g
    │   │   ├── file1
    │   │   ├── file2
    │   │   └── i
    │   └── h
    │       └── i
    ├── file1
    ├── file2
    └── file3
    ```

8. *Hernoem* `file3` naar `file4`

    ```
    $ mv file3 file4
    ```

9. Verplaats `file2` naar directory `f/`

    ```
    $ mv file2 f/
    ```

10. Verplaats `file1` en `file4` in één keer naar `f/h/`. Je zou de gegeven situatie moeten krijgen.

    ```
    $ mv file{1,4} f/h/
    $ tree
    .
    └── f
        ├── file1
        ├── file2
        ├── g
        │   ├── file1
        │   ├── file2
        │   └── i
        └── h
            ├── file1
            ├── file4
            └── i

    5 directories, 6 files
    ```

11. Kopieer `f/h/`, inclusief de inhoud, naar een nieuwe directory `f/j/`

    ```
    $ mv f/h f/j
    ```

### Pathname expansion (of *file globbing*)

Creëer in de directory `linux/` een aantal lege bestanden met de naam `filea` t/m `filed`, `file1` t/m `file9` en `file10` t/m `file19`. Hier is een trucje om dat snel te doen:

```
[student@localhost ~/linux] $ touch filea fileb filec filed
[student@localhost ~/linux] $ for i in {1..19}; do touch "file${i}"; done 
[student@localhost ~/linux] $ ls 
f       file11  file14  file17  file2  file5  file8  fileb 
file1   file12  file15  file18  file3  file6  file9  filec 
file10  file13  file16  file19  file4  file7  filea  filed 
```

Toon met `ls` telkens de gevraagde bestanden, niet meer en niet minder.

1. Alle bestanden die beginnen met `file`

    ```
    $ COMMANDO
    UITVOER
    ```

2. Alle bestanden die beginnen met `file`, gevolgd door één letterteken (cijfer of letter)

    ```
    $ COMMANDO
    UITVOER
    ```

3. Alle bestanden die beginnen met `file`, gevolgd door één letter, maar geen cijfer

    ```
    $ COMMANDO
    UITVOER
    ```

4. Alle bestanden die beginnen met `file`, gevolgd door één cijfer, maar geen letter

    ```
    $ COMMANDO
    UITVOER
    ```

5. De bestanden `file12` t/m `file16`

    ```
    $ COMMANDO
    UITVOER
    ```

6. Bestandern die beginnen met `file`, *niet* gevolgd door een `1`

    ```
    $ COMMANDO
    UITVOER
    ```

### Links

Maak in de directory `linux/` twee tekstbestanden aan, met naam `tekst1a` en `tekst2a`. Beide hebben als inhoud “Dit is bestand tekst1” en “Dit is bestand tekst2”, respectievelijk.

1. Voor het volgende commando uit en geef de uitvoer:

    ```
    $ ls -l tekst*
    UITVOER
    ```

2. Maak een *harde link* aan met naam `tekst1b` die verwijst naar bestand `tekst1a`
3. Maak een *symbolische link* aan met naam `tekst2b` die verwijst naar bestand `tekst2a`
4. Voor het volgende commando uit en geef de uitvoer:

    ```
    $ ls -l tekst*
    UITVOER
    ```

5. Hoe zie je aan de uitvoer van `ls` dat `tekst1b` een harde link is en `tekst2b` een symbolische? Tip: Vergelijk met de uitvoer uit vraag 1!

    **Antwoord**: ...

6. Verwijder de oorspronkelijke bestanden, `tekst1a` en `tekst2a`. Maak het commando zo kort mogelijk!

    ```
    $ COMMANDO
    UITVOER
    ```

7. Toon opnieuw de uitvoer van `ls -l tekst*`, en bekijk de inhoud van `tekst1b` en `tekst2b`. Wat valt je op?

    ```
    $ COMMANDO
    UITVOER
    ```

    **Antwoord**: ...

### Bestanden archiveren

1. Creëer in je home-directory een archief `linux.tar.bz2` van de directory `linux/` en alle inhoud.

    ```
    $ COMMANDO
    UITVOER
    ```

2. Verwijder nu volledig de directory `linux/`

    ```
    $ COMMANDO
    UITVOER
    ```

3. Toon de inhoud van het archief zonder opnieuw uit te pakken

    ```
    $ COMMANDO
    UITVOER
    ```

4. Pak het archief opnieuw uit in je home-directory.

    ```
    $ COMMANDO
    UITVOER
    ```

