# Labo 7: Webserver/LAMP stack

In dit labo zullen we een webserver opzetten in de VM die je in het vorige labo gemaakt hebt.
Een van de populairste toepassingen van Linux als server is de zgn. LAMP-stack. Deze afkorting staat voor Linux + Apache + MySQL + PHP. De combinatie vormt een platform voor het ontwikkelen van webapplicaties waar vele bekende websites gebruik van maken (bv. Facebook).

Als je gebruik maakt van andere bronnen (bv. blog-artikel of HOWTO die je op het Internet vond), voeg die dan toe aan je logboek. Zo kan je die later makkelijk terug vinden.

## De Apache webserver installeren

Het is belangrijk dat je controleert voordat je aan dit labo begint, dat je twee netwerkinterfaces hebt op je virtuele machine. De ene moet van het type *NAT* zijn. Deze heeft verbinding met het internet en heeft typisch als IP-adres 10.0.2.15. De andere netwerkinterface moet van het type *Host-only* zijn. Via deze kan je communiceren met de host-machine en je webserver testen. Als je niets hebt veranderd de standaardinstellingen van VirtualBox, is het IP-adres hoogstwaarschijnlijk 192.168.56.101.

1. Installeer Apache op je virtuele machine en verifieer dat hij draait en vanop je host-machine bereikbaar is.
2. Installeer ondersteuning voor PHP en verifieer dat dit werkt, bijvoorbeeld met een eenvoudige PHP-pagina

### Procedure

Beschrijf hier de exacte procedure hoe je dit uitgevoerd hebt. Zorg er voor dat je aan de hand van je beschrijving deze taken later heel vlot kan herhalen als dat nodig is. Test ook telkens na elke stap dat die correct verlopen is.

1. ...

## MariaDB (MySQL)

MariaDB is de naam van een variant (fork) van de bekende database MySQL. Onder Fedora is MySQL zelf niet meer beschikbaar, maar MariaDB is volledig compatibel. Installeer MariaDB op je virtuele machine. Voer daarna het script `mysql_secure_installation` uit om het root-wachtwoord voor MariaDB in te stellen. Installeer ook PHPMyAdmin, dit is een webinterface voor het beheer van MySQL/MariaDB.


### Procedure

Beschrijf hier de exacte procedure hoe je dit uitgevoerd hebt. Zorg er voor dat je aan de hand van je beschrijving deze taken later heel vlot kan herhalen als dat nodig is. Test ook telkens na elke stap dat die correct verlopen is.

1. ...

## Webapplicatie

Kies een webapplicatie gebaseerd op PHP en installeer op je webserver. Enkele voorbeelden die je kan gebruiken: Drupal, Wordpress, Joomla, MediaWiki, enz.,


### Procedure

Beschrijf hier de exacte procedure hoe je dit uitgevoerd hebt. Zorg er voor dat je aan de hand van je beschrijving deze taken later heel vlot kan herhalen als dat nodig is. Test ook telkens na elke stap dat die correct verlopen is.

1. ...

## Netwerkconfiguratie en troubleshooting

1. Welk(e) IP-adres(sen) heeft je VM? Vul onderstaande tabel aan (voeg rijen toe zoveel als nodig). Welk commando gebruikte je?

    ```
    $ COMMANDO
    UITVOER
    ```

    | Interface | IP-adres | Netwerkmasker |
    | :---      | :---     | :---          |
    |           |          |               |

2. Via welke router/default gateway kan je VM naar het Internet? Welk commando gebruikte je?

    ```
    $ COMMANDO
    UITVOER
    ```

3. Wat is het IP-adres van `www.hogent.be`?

    ```
    $ COMMANDO
    UITVOER
    ```

4. Om het IP-adres van websites en dergelijke op te kunnen vragen, moet je VM kunnen contact maken met een DNS-server. Hoe weet Linux welke DNS-server(s) beschikbaar is/zijn? Geef het configuratiebestand en de huidige inhoud ervan.

    ```
    $ COMMANDO
    UITVOER
    ```

5. In welk(e) configuratiebestanden worden de instellingen van je netwerkinterfaces bijgehouden? Geef hieronder telkens ook de inhoud van deze bestanden:

    ```
    $ COMMANDO
    UITVOER
    ```

6. Met welk commando test je of een host op het netwerk op dit moment online is? Probeer dit uit  vanop je VM met het IP-adres van je host-systeem en voeg de uitvoer hieronder in. Welk protocol uit de TCP/IP familie wordt door deze tool gebruikt?

    ```
    $ COMMANDO
    UITVOER
    ```

7. Met het commando `ss -tln` kan je opvragen welke services er draaien op je systeem, ahv. de open netwerkpoorten. Leg uit wat de opties (`-tln`) betekenen. Probeer het commando uit op je VM wanneer Apache en MariaDB draaien en voeg de uitvoer hieronder in. Geef voor elke open poort beneden de 10.000 welke netwerkservice er mee geassocieerd is.

    ```
    $ COMMANDO
    UITVOER
    ```

## Systeemlogbestanden

Om oorzaken te vinden van problemen op een Linux-systeem, maken systeembeheerders intensief gebruik van zgn. logbestanden. De meeste netwerkservices houden hun eigen logbestand(en), of maken gebruike van het algemene logsysteem dat op recente versies van Fedora `journald` heet.

1. In welke directory horen alle logbestanden volgens de Linux Filesystem Hierarcy Standard thuis?

  **Antwoord:**

2. Met welk commando kan je de algemene systeemlogs bekijken op een recente versie van Fedora?

    ```
    $ COMMANDO
    UITVOER
    ```

3. Met welk commando (incl. opties) kan je de logs blijven bekijken terwijl er nieuwe boodschappen toegevoegd worden? (Ter info: dit afsluiten kan met `<Ctrl-C>`

    ```
    $ COMMANDO
    UITVOER
    ```

4. Met welk commando kan je de logs voor een bepaalde netwerkservice bekijken?

    ```
    $ COMMANDO
    UITVOER
    ```

5. Open in één console het algemene logbestand en hou het open voor nieuwe boodschappen (zoals hierboven gevraagd). Open nu een andere console waar je de host-only netwerkinterface opnieuw opstart. Wat gebeurt er in de logs? Bekijk in het bijzonder de lijnen met `dhclient`.

    ```
    $ COMMANDO
    UITVOER
    ```

6. Wat is de naam van het logbestand waar je kan opvolgen welke webpagina's er opgevraagd worden aan je webserver? **Antwoord:** `BESTAND`
7. Open dit bestand met `tail -f` en laad een webpagina via een webbrowser. Wat gebeurt er in het logbestand?

    ```
    $ COMMANDO
    UITVOER
    ```

## Gebruikte bronnen

- 
