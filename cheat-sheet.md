# Cheat sheet

Voor inspiratie en motivatie voor het bijhouden van dit soort cheat sheets, ga eens kijken naar <https://github.com/bertvv/cheat-sheets/>.

## Packages installeren

`dnf install [PACKAGE]`

## Vim survival guide

- Bij opstarten van Vim kom je terecht in *normal mode*.
- Als je tekst wil invoeren moet je naar *insert mode*.

| Taak                       | Commando |
| :---                       | :---     |
| Normal mode -> insert mode | `i`      |
| Insert mode -> normal mode | `<Esc>`  |
| Opslaan                    | `:w`     |
| Opslaan en afsluiten       | `:wq`    |
| Afsluiten zonder opslaan   | `:q!`    |

## Bash scripting starter pack

```sh
#! /bin/bash/

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
```
