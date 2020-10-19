# Labo 4: Intro scripting

Als je gebruik maakt van andere bronnen (bv. blog-artikel of HOWTO die je op het Internet vond), voeg die dan toe aan het einde van dit document. Zo kan je het later makkelijk terug vinden.

Maak ter voorbereiding zeker de oefeningen in Linux Fundamentals (Paul Cobbaut) over dit onderwerp (pp. 97, 174 en 181).

## Variabelen

Geef zoals gewoonlijk het commando om de opgegeven taak uit te voeren en controleer ook het resultaat.

1. Druk met behulp van de juiste systeemvariabele de gebruikte bash-versie af op het scherm. Geef het gebruikte commando weer.

    ```sh
    $BASH_VERSION
    ```

2. Je bent ingelogd als gewone gebruiker.
    1. Maak een variabele `pinguin` aan en geef deze de waarde Tux.

        ```sh
        penguin='Tux'
        ```

    2. Hoe kan je de inhoud opvragen van deze variabele en afdrukken op het scherm?

        ```sh
        printf '%s\n' "${penguin}"
        ```

    3. Open nu een sub(bash)shell in je huidige bashomgeving.

        ```sh
        /home/mustachio/scripts/ANDERE-SCRIPT.sh
        ```

        **Alles tussen `()` wordt ook in een subshell gerunned.**
    4. Hoe kan je controleren dat er nu twee bashshells actief zijn en dat de ene een subshell is van de andere?
        **`$BASH_SUBSHELL` toont in welke shell je bent.**
    5. Probeer nu in deze nieuwe subshell de inhoud van de variabele PINGUIN af te drukken op het scherm. Lukt dit?
        **Neen.**
    6. De verklaring hiervoor ligt in het type variabele. Welke soort variabele is PINGUIN en hoe kan je dit controleren? Keer hiervoor terug naar je oorspronkelijke bashshell
        **Lokaal, als penguin leeg is in de subshell is ze niet global.**
    7. Zorg er nu voor dat de inhoud van PINGUIN ook in elke nieuwe subshell kan gelezen worden? Hoe doe je dit? Schrijf het gebruikte commando neer.
        **`export penguin` maakt de variabele available voor alle subshells.**
    8. Open opnieuw een sub(bash)shell in je huidige bashomgeving en controleer of je nu de inhoud van PINGUIN kan lezen. Welk soort variabele is PINGUIN nu? Doe dan ook de controle.
3. Zoek de inhoud op van volgende shellvariabelen en vul volgende tabel aan:

    | Variabele  | Waarde |
    | :---       | :---   |
    | `PATH`     |   `/home/mustachio/.local/bin:/home/mustachio/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin`  |
    | `HISTSIZE` |  `1000`  |
    | `UID`      |  `1000`  |
    | `HOME`     |  `/home/mustachio`  |
    | `HOSTNAME` |  `localhost.localdomain`  |
    | `LANG`     |  `en_GB.UTF-8`  |
    | `USER`     |  `mustachio`  |
    | `OSTYPE`   |  `linux-gnu`  |
    | `PWD`      |  `/home/mustachio/scripts`  |
    | `MANPATH`  |  *unbound*  |
