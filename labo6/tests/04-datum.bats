#! /usr/bin/env bats
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Testscript voor Labo 6, oefening 4 ‘datum.sh’

script="datum.sh"

teardown() {
  rm -rf /tmp/tmp.*
}

@test "Het script ${script} moet bestaan" {
  [ -f "${script}" ]
}

@test "Het script moet uitvoerbaar zijn" {
  [ -x "${script}" ]
}

@test "Een Bash-script moet met een ‘shebang’ beginnen" {
  head -1 "${script}" | grep '#!.*bash.*'
}

@test "Het script moet syntactisch correct zijn" {
  bash -n "${script}"
}

@test "Controle met Shellcheck geeft geen waarschuwingen" {
  # Eén uitzondering: SC2046, "Quote this to prevent word splitting"
  # In dit script moet ‘set $(date)’ zonder aanhalingstekens, want het splitsen
  # van woorden is iets dat we hier expliciet willen
  shellcheck --exclude=SC2046 "${script}"
}

@test "Gebruik het commando ‘set’ om datum als positionele parameters in te stellen" {
  grep '^[[:space:]]*set.*date'  "${script}"
}

@test "Gebruik een while lus" {
  grep '^[[:space:]]*while'  "${script}"
}

@test "Controleer uitvoer" {
  output=$(mktemp)
  day=$(date | sed -e 's/  / /g')

  # Schrijf uitvoer weg naar tijdelijk bestand
  bash "${script}" > "${output}"

  # Aantal lijnen van dat bestand moet 7 zijn
  num_lines=$(cat ${output} | wc --words)
  [ "${num_lines}" -eq "7" ]

  # Als je de inhoud van het bestand terug op 1 lijn brengt, moet
  # het resultaat "6 " gevolgd door de datum zijn
  [ "$(cat ${output} | xargs echo)" = "6 ${day}" ]

}
