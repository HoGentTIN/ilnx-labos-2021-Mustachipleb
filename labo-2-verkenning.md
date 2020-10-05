# Labo 2: Linux leren kennen

## Hulp zoeken

1. Hoe vraag je op de command-line documentatie op voor het *commando* `passwd`?

    ```bash
    $ man passwd
    UITVOER
    ```

2. Hoe vraag je documentatie op voor het *configuratiebestand* `/etc/passwd`?

    ```bash
    $ man 5 passwd
    UITVOER
    ```

3. Hoe vraag je een lijst op van alle documentatie die de string `passwd` bevat?

    ```bash
    $ man -k passwd
    UITVOER
    ```

## Werken op de command-line

1. Wat is de huidige datum en uur?

    ```bash
    $ date
    Mon 28 Sep 11:25:23 CEST 2020
    ```

2. Wat is de huidige directory?

    ```bash
    $ pwd
    /home/mustachio
    ```

3. Toon de inhoud van de huidige directory. De uitvoer zou er ongeveer zo moeten uit zien:

    ```bash
    $ ls
    Desktop  Documents  Downloads  Music  Pictures  Public  Templates  Videos
    ```

4. Toon de inhoud van de huidige directory, maar toon voor elk bestand meer informatie en ook "verborgen" bestanden.

    ```bash
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

    ```bash
    $ ls -l /
    UITVOER
    ```

6. Wat betekenen volgende elementen van de uitvoer hierboven?
    - 1e kolom (bv. `drwxr-xr-x.`): Read & write permission
    - 2e kolom (getal): Aantal harde links naar dit bestand
    - 3e kolom (bv. `root`, `student`): Owner
    - 4e kolom (bv. `root`): Group owner
    - 5e kolom (getal): Size (directories always show as 4096)
    - 6e - 8e kolom (datum): Date modified
    - de aanduiding `->` (bv. `bin -> usr/bin`): Symbolic link aka. shortcut
7. Hoe kan je commando's die je voordien uitgevoerd hebt terug ophalen (de "commandogeschiedenis")?

    ```bash
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

    ```bash
    mkdir tijdelijk
    mv tijdelijk /tmp/
    ```

2. Verwijder deze directory meteen

    ```bash
    rmdir /tmp/tijdelijk
    ```

3. Maak onder je home-directory een submap aan met de naam `linux/`

    ```bash
    mkdir linux
    ```

4. Ga naar deze directory

    ```bash
    cd linux
    ```

5. Maak met één commando de subdirectory `a/b/` aan onder `linux/`. Als je nadien het commando `tree` geeft, moet je de gegeven uitvoer zien.

    ```bash
    $ mkdir -p a/b/
    $ tree
    .
    └── a
        └── b
    2 directories, 0 files
    ```

6. Verwijder directory `b/` en daarna `a/` (in twee commando's)

    ```bash
    rmdir a/b
    rmdir a
    ```

7. Maak met één commando deze directorystructuur aan.

    ```bash
    $ mkdir -p {c/d/,c/e/}
    $ tree
    .
    └── c
        ├── d
        └── e
    3 directories, 0 files
    ```

8. Verwijder in één commando de directory `c/` en alle onderliggende

    ```bash
    rmdir c/d/ c/e/ c
    ```

9. Maak met één commando deze directorystructuur aan. Het is de bedoeling de opdrachtregel zo kort mogelijk te maken, dus niet alle directories apart opgeven!

    ```bash
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

    ```bash
    touch file1
    ```

2. Maak een *verborgen* bestand aan met de naam `hidden`. Verborgen betekent dat je het niet kan zien met een "gewone" `ls`, maar wel met de gepaste optie.

    ```bash
    touch .hidden
    ```

3. Tik volgend commando in, leg uit wat er hier precies gebeurt, wat het effect is.

    ```bash
    echo hello world > file2
    ```

    Schrijft "hello world" in een bestand genaamd file2.

4. Toon de inhoud van `file2`

    ```bash
    cat file2
    ```

5. Kopieer `file1` naar een nieuw bestand `file3` in de huidige directory

    ```bash
    cp file1 file3
    ```

6. Kopieer `file1` naar de directory `f/` (die zou je nog moeten hebben van vorige oefening)

    ```bash
    cp file1 f/
    ```

7. Kopieer `file1` en file2 in één keer naar `f/g/`. Je zou de gegeven situatie moeten krijgen.

    ```bash
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

    ```bash
    mv file3 file4
    ```

9. Verplaats `file2` naar directory `f/`

    ```bash
    mv file2 f/
    ```

10. Verplaats `file1` en `file4` in één keer naar `f/h/`. Je zou de gegeven situatie moeten krijgen.

    ```bash
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

    ```bash
    mv f/h f/j
    ```

### Pathname expansion (of *file globbing*)

Creëer in de directory `linux/` een aantal lege bestanden met de naam `filea` t/m `filed`, `file1` t/m `file9` en `file10` t/m `file19`. Hier is een trucje om dat snel te doen:

```bash
[student@localhost ~/linux] $ touch filea fileb filec filed
[student@localhost ~/linux] $ for i in {1..19}; do touch "file${i}"; done 
[student@localhost ~/linux] $ ls 
f       file11  file14  file17  file2  file5  file8  fileb 
file1   file12  file15  file18  file3  file6  file9  filec 
file10  file13  file16  file19  file4  file7  filea  filed 
```

Toon met `ls` telkens de gevraagde bestanden, niet meer en niet minder.

1. Alle bestanden die beginnen met `file`

    ```bash
    $ ls file*
    file1   file11  file13  file15  file17  file19  file3  file5  file7  file9
    file10  file12  file14  file16  file18  file2   file4  file6  file8
    ```

2. Alle bestanden die beginnen met `file`, gevolgd door één letterteken (cijfer of letter)

    ```bash
    $ ls file?
    file1  file2  file3  file4  file5  file6  file7  file8  file9
    ```

3. Alle bestanden die beginnen met `file`, gevolgd door één letter, maar geen cijfer

    ```bash
    $ ls file[a-z]
    filea  fileb  filec  filed
    ```

4. Alle bestanden die beginnen met `file`, gevolgd door één cijfer, maar geen letter

    ```bash
    $ ls file[1-9]
    file1  file2  file3  file4  file5  file6  file7  file8  file9
    ```

5. De bestanden `file12` t/m `file16`

    ```bash
    $ ls file1[2-6]
    file12  file13  file14  file15  file16
    ```

6. Bestandern die beginnen met `file`, *niet* gevolgd door een `1`

    ```bash
    $ ls file[2-9]*
    file2  file3  file4  file5  file6  file7  file8  file9
    ```

### Links

Maak in de directory `linux/` twee tekstbestanden aan, met naam `tekst1a` en `tekst2a`. Beide hebben als inhoud “Dit is bestand tekst1” en “Dit is bestand tekst2”, respectievelijk.

1. Voor het volgende commando uit en geef de uitvoer:

    ```bash
    $ ls -l tekst*
    -rw-r--r--. 1 root      root      22 Oct  5 11:56 tekst1a
    -rw-rw-r--. 1 mustachio mustachio 22 Oct  5 11:57 tekst2a
    ```

2. Maak een *harde link* aan met naam `tekst1b` die verwijst naar bestand `tekst1a`
3. Maak een *symbolische link* aan met naam `tekst2b` die verwijst naar bestand `tekst2a`
4. Voor het volgende commando uit en geef de uitvoer:

    ```bash
    $ ls -l tekst*
    -rw-r--r--. 2 root      root      22 Oct  5 11:56 tekst1a
    -rw-r--r--. 2 root      root      22 Oct  5 11:56 tekst1b
    -rw-rw-r--. 1 mustachio mustachio 22 Oct  5 11:57 tekst2a
    lrwxrwxrwx. 1 root      root       7 Oct  5 12:05 tekst2b -> tekst2a
    ```

5. Hoe zie je aan de uitvoer van `ls` dat `tekst1b` een harde link is en `tekst2b` een symbolische? Tip: Vergelijk met de uitvoer uit vraag 1!

    **Antwoord**: De 2de kolom gaat naar boven bij een harde link, en bij een symlink wordt dit aangewezen met een pijl.

6. Verwijder de oorspronkelijke bestanden, `tekst1a` en `tekst2a`. Maak het commando zo kort mogelijk!

    ```bash
    $ rm tekst[1-2]a
    UITVOER
    ```

7. Toon opnieuw de uitvoer van `ls -l tekst*`, en bekijk de inhoud van `tekst1b` en `tekst2b`. Wat valt je op?

    ```bash
    $ ls -l tekst*
    -rw-r--r--. 1 root root 22 Oct  5 11:56 tekst1b
    lrwxrwxrwx. 1 root root  7 Oct  5 12:05 tekst2b -> tekst2a
    ```

    **Antwoord**: De symlink is nu rood aangeduid.

### Bestanden archiveren

1. Creëer in je home-directory een archief `linux.tar.bz2` van de directory `linux/` en alle inhoud.

    ```bash
    $ tar cvfj linux.tar.bz2 linux/
    linux/
    linux/file9
    linux/file13
    linux/file15
    linux/file17
    linux/file2
    linux/file6
    linux/file7
    linux/file4
    linux/fileb
    linux/f/
    linux/f/file2
    linux/f/file1
    linux/f/j/
    linux/f/j/file4
    linux/f/j/i/
    linux/f/j/file1
    linux/f/g/
    linux/f/g/file2
    linux/f/g/i/
    linux/f/g/file1
    linux/tekst2b
    linux/file10
    linux/filec
    linux/file1
    linux/file14
    linux/file8
    linux/file5
    linux/file3
    linux/file12
    linux/file19
    linux/filed
    linux/file16
    linux/.hidden
    linux/file18
    linux/file11
    linux/tekst1b
    linux/filea
    ```

2. Verwijder nu volledig de directory `linux/`

    ```bash
    sudo rm -rf linux/
    ```

3. Toon de inhoud van het archief zonder opnieuw uit te pakken

    ```bash
    $ tar -tvf linux.tar.bz2
    drwxrwxr-x mustachio/mustachio 0 2020-10-05 12:17 linux/
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file9
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file13
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file15
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file17
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file2
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file6
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file7
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:27 linux/file4
    -rw-rw-r-- mustachio/mustachio 0 2020-10-05 11:30 linux/fileb
    drwxrwxr-x mustachio/mustachio 0 2020-09-28 12:21 linux/f/
    -rw-rw-r-- mustachio/mustachio 12 2020-09-28 12:15 linux/f/file2
    -rw-rw-r-- mustachio/mustachio  0 2020-09-28 12:16 linux/f/file1
    drwxrwxr-x mustachio/mustachio  0 2020-09-28 12:19 linux/f/j/
    -rw-rw-r-- mustachio/mustachio  0 2020-09-28 12:16 linux/f/j/file4
    drwxrwxr-x mustachio/mustachio  0 2020-09-28 12:16 linux/f/j/i/
    -rw-rw-r-- mustachio/mustachio  0 2020-09-28 12:13 linux/f/j/file1
    drwxrwxr-x mustachio/mustachio  0 2020-09-28 12:18 linux/f/g/
    -rw-rw-r-- mustachio/mustachio 12 2020-09-28 12:18 linux/f/g/file2
    drwxrwxr-x mustachio/mustachio  0 2020-09-28 12:16 linux/f/g/i/
    -rw-rw-r-- mustachio/mustachio  0 2020-09-28 12:18 linux/f/g/file1
    lrwxrwxrwx root/root            0 2020-10-05 12:05 linux/tekst2b -> tekst2a
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file10
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:30 linux/filec
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file1
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file14
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file8
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file5
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file3
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file12
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file19
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:30 linux/filed
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file16
    -rw-rw-r-- mustachio/mustachio  0 2020-09-28 12:13 linux/.hidden
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file18
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:27 linux/file11
    -rw-r--r-- root/root           22 2020-10-05 11:56 linux/tekst1b
    -rw-rw-r-- mustachio/mustachio  0 2020-10-05 11:30 linux/filea
    ```

4. Pak het archief opnieuw uit in je home-directory.

    ```bash
    $ tar -xvf linux.tar.bz2
    linux/
    linux/file9
    linux/file13
    linux/file15
    linux/file17
    linux/file2
    linux/file6
    linux/file7
    linux/file4
    linux/fileb
    linux/f/
    linux/f/file2
    linux/f/file1
    linux/f/j/
    linux/f/j/file4
    linux/f/j/i/
    linux/f/j/file1
    linux/f/g/
    linux/f/g/file2
    linux/f/g/i/
    linux/f/g/file1
    linux/tekst2b
    linux/file10
    linux/filec
    linux/file1
    linux/file14
    linux/file8
    linux/file5
    linux/file3
    linux/file12
    linux/file19
    linux/filed
    linux/file16
    linux/.hidden
    linux/file18
    linux/file11
    linux/tekst1b
    linux/filea
    ```
