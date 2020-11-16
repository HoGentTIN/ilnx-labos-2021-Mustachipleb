# Labo 5: Bestandspermissies

Als je gebruik maakt van andere bronnen (bv. blog-artikel of HOWTO die je op het Internet vond), voeg die dan toe aan het einde van dit document. Zo kan je het later terug vinden.

Maak ter voorbereiding zeker de oefeningen in Linux Fundamentals (Paul Cobbaut) over dit onderwerp (pp. 222 en 228).

## Gebruikers en groepen aanmaken

Het doel van deze opgave is om de opdrachten en de begrippen met betrekking tot  gebruikers en groepen te bestuderen, binnen de context van Linux als een multi-user-systeem.

Tussen de vragen is ruimte voorzien om je antwoorden in te vullen. Het gaat telkens om zgn. codeblokken in Markdown, die starten en eindigen met drie backquotes. Binnen elk codeblok geef je telkens het commando dat je hebt ingetikt en de uitvoer die je krijgt.

1. Je hebt al een gebruiker aangemaakt voor jezelf. Log in als deze gebruiker. Geef hieronder telkens het commando en de uitvoer
    - Wat is het commando om de huidige directory op te vragen? Welke uitvoer toont het commando?

        ```bash
        $ pwd
        /home/mustachio
        ```

    - Wat is het UID van deze gebruiker?

        ```bash
        $ id
        uid=1000(mustachio) gid=1000(mustachio) groups=1000(mustachio),10(wheel) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        ```

    - Wat is het GID van deze gebruiker?

        ```bash
        $ id
        uid=1000(mustachio) gid=1000(mustachio) groups=1000(mustachio),10(wheel) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        ```

2. Log in als de `root`-gebruiker met het commando `su -` (let op de spatie!)
    - Wat is de home-directory van `root`?

        ```bash
        $ cd
        $ pwd
        /root
        ```

    - Wat is het UID van deze gebruiker?

        ```bash
        $ id
        uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        ```

    - Wat is het GID van deze gebruiker?

        ```bash
        $ id
        uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        ```

3. Maak een nieuwe gebruiker aan met de naam `alice`, zonder specifieke opties
    - Geef het gebruikte commando:

        ```bash
        useradd alice
        ```

    - Voorzie een geschikt wachtwoord voor deze gebruiker (en vergeet het niet! Noteer het eventueel hier in je verslag of in de beschrijving van je VM)

        ```bash
        $ passwd alice
        Changing password for user alice.
        New password:
        Retype new password:
        passwd: all authentication tokens updated successfully.
        ```

4. Configuratiebestanden voor gebruikersbeheer:
    - In welk bestand kan je de UID, gebruikersnaam, homedirectory, enz. van alle gebruikers terugvinden?

        ```bash
        /etc/passwd
        ```

    - In welk configuratiebestand kan je al de bestaande gebruikersgroepen nakijken, en ook de gebruikers die lid zijn van elke groep?

        ```bash
        /etc/group
        ```

    - In welk configuratiebestand vind je de *wachtwoorden* van alle gebruikers?

        ```bash
        /etc/shadow
        ```

5. Gebruikersgroepen aanmaken
    - Maak een groep aan met de naam `sporten`

        ```bash
        groupadd sporten
        ```

    - In welk configuratiebestand vind je het GID van deze groep terug?

        ```bash
        /etc/group
        ```

    - Wat zal het GID zijn van de groepen `zwemmen` en `judo` als je deze nu onmiddellijk zou aanmaken? Maak ze aan en controleer!

        1003 & 1004

        ```bash
        groupadd zwemmen
        groupadd judo
        ```

    - Voeg de gebruiker `alice` toe aan de groepen `sporten` en `zwemmen`

        ```bash
        usermod -aG sporten alice
        usermod -aG zwemmen alice
        ```

    - Log in als `alice` door in een terminal het commando `su - alice` (let op de spaties!) uit te voeren

        ```bash
        $ su - alice
        [alice@localhost ~]$
        ```

    - Zorg er nu voor dat de groep `sporten` de primaire groep wordt van `alice`.

        ```bash
        sudo usermod -g sporten alice
        ```

    - Zorg er voor dat `alice` uitgelogd is, ga terug naar `root`

        ```bash
        [alice@localhost ~]$ logout
        [mustachio@localhost ~]$ su -
        Password:
        [root@localhost ~]#
        ```

6. Maak nu de gebruikers in onderstaande tabel aan. Zorg er voor dat ze al meteen bij aanmaken tot de aangegeven groepen behoren. Kies zelf geschikte wachtwoorden voor deze gebruikers en vergeet ze niet (vul eventueel een kolom toe aan de tabel).

    | Gebruikersnaam | Primaire groep | Secundaire groep |
    | :---           | :---           | :---             |
    | `bob`          | `sporten`      | `judo`           |
    | `carol`        | `sporten`      | `zwemmen`        |
    | `daniel`       | `sporten`      | `judo`           |
    | `eva`          | `sporten`      | `zwemmen`        |

    - Geef de gebruikte commando's om de gebruikers aan te maken en ook om te verifiëren of dit correct gebeurd is:

        ```bash
        useradd bob -g 1002 -G judo
        useradd carol -g 1002 -G zwemmen
        useradd daniel -g 1002 -G judo
        useradd eva -g 1002 -G zwemmen
        ```

    - Verwijder nu de *groep* `alice` en controleer.

        ```bash
        groupdel alice
        ```

    - Gebruiker `daniel` gaat een tijdje niet meer sporten. Zorg er voor dat deze gebruiker tot nader order geen toegang meer kan hebben tot het systeem (zonder het wachtwoord of de gebruiker te verwijderen!).

        ```bash
        usermod -s /sbin/nologin daniel
        ```

    - Hoe kan je controleren dat `daniel` inderdaad geen toegang meer heeft tot het systeem? In welk bestand kan dat en hoe zie je daar dan dat het account afgesloten is?

        ```bash
        $ grep ^daniel /etc/passwd
        daniel:x:1004:1002::/home/daniel:/sbin/nologin
        ```

        Hij heeft geen shell om aan in te loggen.

    - Gebruiker `daniel` komt terug naar de sportclub. Geef hem opnieuw toegang tot het systeem.

        ```bash
        usermod -s /bin/bash daniel
        ```

    - Gebruiker `eva` stopt helemaal met sporten. Verwijder deze gebruiker, maar doe dit zorgvuldig: zorg er in het bijzonder voor dat ook haar homedirectory verwijderd wordt.

        ```bash
        userdel -r eva
        ```

7. Log aan als de gebruiker `carol`

    ```bash
    su - carol
    ```

    - Controleer of je in de “thuismap” bent van deze gebruiker. Maak onder deze map een bestand `test` aan door middel van het commando `touch`.

        ```bash
        [carol@localhost ~]$ pwd
        /home/carol
        [carol@localhost ~]$ touch test
        [carol@localhost ~]$
        ```

    - Probeer nu als gebruiker `carol` je te verplaatsen naar de “thuismap” van `alice`.

        ```bash
        [carol@localhost ~]$ cd /home/alice
        -bash: cd: /home/alice: Permission denied
        [carol@localhost ~]$

        ```

    - Kan je de inhoud van de mappen binnen de thuismap van `alice` bekijken?

        ```bash
        [carol@localhost ~]$ cd /home/alice
        -bash: cd: /home/alice: Permission denied
        ```

    - Probeer nu als `carol` onder de “thuismap” van `alice` ook een bestand `test` te maken. Lukt dit? Kan je dit verklaren?

        ```bash
        [carol@localhost ~]$ touch /home/alice/test
        touch: cannot touch '/home/alice/test': Permission denied
        ```

## Algemene permissies

Geef in de volgende oefeningen telkens het commando dat nodig is om de taak uit te voeren en ook het resultaat.

1. Log in als gewone gebruiker. Wat is de waarde van umask?

    ```bash
    [mustachio@localhost ~]$ umask
    0002
    ```

2. Maak een directory `oefenenMetPermissies` aan. Welke octale permissies verwacht je voor deze nieuwe directory?

    ```bash
    [mustachio@localhost ~]$ mkdir oefenenMetPermissies
    ```

    ```bash
      0777
    - 0002
    ------
      0775
    ```

3. Controleer dit door de *symbolische* permissies op te vragen.

    ```bash
    [mustachio@localhost ~]$ stat -c '%A %a %n' oefenenMetPermissies/
    drwxrwxr-x 775 oefenenMetPermissies/
    ```

4. Controleer of de symbolische waarden en octale waarden overeen komen!
5. Stel nu de umask waarde zo in dat niemand permissies heeft op de bestanden en directories die je aanmaakt, behalve jijzelf.

    ```bash
    [mustachio@localhost ~]$ sudo nano ~/.bashrc
    ```

    In .bashrc add ``umask 077``.

6. Maak nu een bestand aan met de naam `vanmij`, in de directory `oefenenMetPermissies` met als inhoud de tekst: `echo "Waarschuwing: eigendom van ${USER}!"` Schrijf neer hoe je dit bestand gemaakt hebt. Controleer de permissies; schrijf ze neer en was dit wat je verwachtte? Verklaar!

    ```bash
    [mustachio@localhost oefenenMetPermissies]$ sudo nano vanmij.sh
    ```

    De octale permissies zijn 600, omdat files default niet executable rechten krijgen.

7. Verander nu de permissies van het bestand `vanmij` zodat je zelf het bestand kan uitvoeren. Geef het gebruikte commando (op de octale manier) en test het resultaat.

    ```bash
    [mustachio@localhost oefenenMetPermissies]$ sudo chmod u+x vanmij.sh
    [mustachio@localhost oefenenMetPermissies]$ stat -c '%A %a %n' vanmij.sh
    -rwx------ 700 vanmij.sh
    [mustachio@localhost oefenenMetPermissies]$
    ```

8. Log in als de gebruiker `alice` (als je deze niet meer hebt, maak je die aan en voorzie de gebruiker van een eenvoudig paswoord), maar zorg dat je niet verandert van directory. Kan `alice` het bestand `vanmij` uitvoeren? Verklaar!

    ```bash
    [alice@localhost ~]$ bash /home/mustachio/oefenenMetPermissies/vanmij.sh
    bash: /home/mustachio/oefenenMetPermissies/vanmij.sh: Permission denied
    [alice@localhost ~]$
    ```

    Alice kan hoe dan ook niet aan /home/mustachio. En zelfs dan, door u+x kan alleen mustachio het bestand uitvoeren.

9. Verander nu de permissies van het bestand vanmij zodat iedereen het bestand kan uitvoeren. Geef het gebruikte commando (op de symbolische manier) en test het resultaat.

    ```bash
    [mustachio@localhost oefenenMetPermissies]$ sudo chmod o+x vanmij.sh
    ```

    Theoretisch kan Alice het nu uitvoeren, maar ze heeft nog steeds geen toegang tot /home/mustachio.

## Geavanceerde permissies

1. Zoek alle bestanden in het systeem waar de SUID-permissie op ingesteld staat. Schrijf het resultaat in een bestand met de naam `suidBestanden. Schrijf de fouten weg naar een `foutenBestand`. Doe dit in één commandolijn. (Tip: gebruik het commando `find` en zoek in de manpages naar de geschikte opties).

    ```bash
    find / -perm /4000 > suidBestanden 2> foutenBestand
    ```

2. Controleer het resultaat door een bestand te nemen uit `suidBestanden` en de permissies op te vragen van dat bestand.

    ```bash
    $ ls -l "$(head -1 suidBestanden)"
    -rwsr-xr-x. 1 root root 83752 Mar 26  2020 /usr/bin/chage
    ```

3. Check of het programmabestand `/usr/bin/passwd` in het bestand `suidBestanden` aanwezig is. Schrijf het gebruikte commando op. Is het aanwezig?

    ```bash
    $ grep /usr/bin/passwd suidBestanden
    /usr/bin/passwd
    ```

## Geavanceerde permissies: setGID en de *sticky bit*

1. Ga naar de directory `oefenenMetPermissies`, als gewone gebruiker (dus niet als `root`) en kopieer het bestand `/etc/hosts` daar naartoe.

    ```bash
    cp /etc/hosts ./
    ```

2. Verander nu de permissies van het bestand `hosts` in directory `oefenenMetPermissies` als volgt: SGID aan, `rx` voor *others*, `rw` voor *group* en geen permissies voor de eigenaar (merk op dat deze combinatie van permissies geen praktisch nut heeft!). Geef het gebruikte commando en ook het commando om te controleren of de permissies juist ingesteld zijn.

    ```bash
    sudo chmod 0065 hosts
    ```

3. Kan de eigenaar nu het bestand bekijken? Waarom wel of niet? Noteer hoe je dit controleert:

    ```bash
    $ cat hosts
    cat: hosts: Permission denied
    ```

4. Kan de eigenaar de permissies wijzigen? Controleer.
   **Ja**

    ```bash
    $ chmod 0067 hosts
    $ ls -l
    total 8
    ----rw-rwx. 1 mustachio mustachio 158 Nov 16 13:05 hosts
    -rwx-----x. 1 root      root       57 Oct 26 11:37 vanmij.sh
    ```

5. Kan de eigenaar het bestand verwijderen? Controleer.
   **Ja**

    ```bash
    unlink hosts
    ```

Kopieer als je eigen gebruiker (niet als root!) nu opnieuw het bestand `/etc/hosts` in het directory `oefenenMetPermissies` en pas de permissies opnieuw aan zoals eerder voorgeschreven. Zorg dat gebruiker `alice` lid is van de groep die groepseigenaar is van het bestand `hosts` in directory `oefenenMetPermissies`. Switch nu naar gebruiker alice.

1. Kan alice nu het bestand bekijken? Controleer.

    ```bash
    $ tail hosts
    127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
    ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
    ```

2. Kan alice de permissies wijzigen? Controleer.
   **Nee**

    ```bash
    $ chmod 0067 hosts
    chmod: changing permissions of 'hosts': Operation not permitted
    ```

3. Kan alice het bestand verwijderen? Is dit de bedoeling? Controleer.
    **Het is logisch, want om een file te kunnen deleten moet de user +wx hebben op de parent folder.**

    ```bash
    $ unlink hosts
    unlink: cannot unlink 'hosts': Permission denied
    ```

4. Stel nu de sticky-bit in op het directory oefenenMetPermissies. Geef het geschikte commando en controleer het resultaat.

    ```bash
    $ chmod +t hosts
    $ ls -l
    total 8
    ----rw-r-t. 1 mustachio sporten 158 Nov 16 13:25 hosts
    -rwx-----x. 1 root      root     57 Oct 26 11:37 vanmij.sh
    ```

## Eigenaars en groepseigenaars veranderen

1. Maak als `root` onder `/srv/` twee directories aan met de naam `groep/verkoop` en `groep/inkoop`. Maak ook 2 groepen aan met de namen `verkoop` en `inkoop`. Maak twee gebruikers aan, `margriet` met primaire groep `verkoop` en `roza`, die als primaire groep `inkoop` heeft. Zorg dat de groepen eigenaar zijn van de overeenkomstige directories en dat `margriet` eigenaar is van directory `verkoop` en `roza` van het directory `inkoop`. Geef de gebruikte commando’s en controleer:

    ```bash
    $ mkdir -p {groep/verkoop/,groep/inkoop/}
    $ groupadd verkoop
    $ groupadd inkoop
    $ useradd -g verkoop margriet
    $ useradd -g inkoop roza
    $ chown margriet:verkoop verkoop
    $ chown roza:inkoop inkoop
    $ ls -l
    total 8
    drwxr-xr-x. 2 roza     inkoop  4096 Nov 16 13:45 inkoop
    drwxr-xr-x. 2 margriet verkoop 4096 Nov 16 13:45 verkoop
    ```

2. Zorg ervoor dat gebruikers en groepen uit de vorige stap alle permissies hebben. Geef het geschikte commando en controleer.

    ```bash
    chmod 0770 inkoop
    chmod 0770 verkoop
    ```

3. Voeg een gebruiker, vb `alice`, toe aan de groep `inkoop` en `verkoop` en controleer. Geen van beide groepen zijn primair.

    ```bash
    $ usermod -a -G inkoop alice
    $ usermod -a -G verkoop alice
    $ groups alice
    alice : sporten inkoop zwemmen verkoop
    ```

4. Log in als `alice` en ga naar de directory verkoop. Laat de gebruiker hier een leeg bestand, `bestand1`, aanmaken in de directory verkoop. (Indien je hier problemen ondervindt, log dan in via een andere terminalvenster).

    ```bash
    touch bestand1
    ```

5. Wie is nu eigenaar van `bestand1` en wie de groepseigenaar?

    ```bash
    $ ls -l
    total 0
    -rw-r--r--. 1 alice sporten 0 Nov 16 13:59 bestand1
    ```

6. Zorg er nu voor dat de groepseigenaar van de directory `verkoop` automatisch de groepseigenaar wordt van alle bestanden en directories die onder `verkoop` gemaakt worden. Geef de gebruikte commando’s.

    ```bash
    chmod 2770 verkoop/
    ```

7. Doe hetzelfde voor de directory `inkoop`. Geef de gebruikte commando’s:

    ```bash
    chmod 2770 inkoop/
    ```

8. Verander opnieuw naar gebruiker `alice` en laat deze gebruiker een leeg `bestand2` aanmaken in de directory `verkoop`. Geef de gebruikte commando’s:

    ```bash
    touch bestand2
    ```

9. Wie is nu eigenaar van `bestand2` en wie groepseigenaar?

    ```bash
    $ ls -l
    total 0
    -rw-r--r--. 1 alice sporten 0 Nov 16 13:59 bestand1
    -rw-r--r--. 1 alice verkoop 0 Nov 16 14:12 bestand2
    ```

10. Laat nu gebruiker `margriet` een leeg bestand `bestand3` aanmaken. Controleer de eigenaar van `bestand3` en de groepseigenaar.

    ```bash
    $ ls -l
    total 0
    -rw-r--r--. 1 alice    sporten 0 Nov 16 13:59 bestand1
    -rw-r--r--. 1 alice    verkoop 0 Nov 16 14:12 bestand2
    -rw-r--r--. 1 margriet verkoop 0 Nov 16 14:13 bestand3
    ```

11. Laat nu gebruiker `alice` `bestand3` verwijderen. Lukt dit?

    **Ja, de verkoop folder heeft +rwx voor verkoop, waar alice deel van is.**

12. Zorg er nu voor dat de gebruikers elkaars bestanden niet kunnen verwijderen. Als de gebruiker echter eigenaar is van het betreffende directory mag dit wel. Leg uit hoe je dit doet en controleer. Schrijf je gevolgde procedure op.

    ```bash
    chmod +t verkoop/
    ```

## Gebruikte bronnen

[Permissions Calculator](http://www.permissions-calculator.org)
