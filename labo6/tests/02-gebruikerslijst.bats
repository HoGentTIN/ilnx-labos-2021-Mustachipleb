#! /usr/bin/env bats
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Testscript voor opgave Labo 6 ‘onderelkaar.sh’

script="gebruikerslijst.sh"

teardown() {
  # Verwijder eventuele tijdelijke bestanden
  rm -f /tmp/tmp*
}

# Usage: assert_user_exists STRING FILE
# Exit status 0 if FILE contains STRING, a nonzero exit status otherwise
assert_user_exists() {
  grep --silent "^${1}$" "${2}"
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
  shellcheck "${script}"
}

@test "De uitvoer mag max. één woord per lijn bevatten" {
  tmpfile=$(mktemp)
  bash "${script}" > "${tmpfile}"

  # Zoek in het resultaat van het script naar lijnen die *niet* in de juiste
  # vorm staan. De regexp zoekt naar lijnen met geldige gebruikersnamen.
  # Door --invert-match worden enkel de foute lijnen getoond
  run grep --invert-match --extended-regexp "^[A-Za-z_][A-Za-z0-9_-]{1,31}$" "${tmpfile}"

  # De uitvoer van de zoekopdracht van hierboven moet leeg zijn
  echo -e "Volgende lijnen zijn niet in de verwachte vorm:\n${output}"
  [ -z "${output}" ]
}

@test "Resultaat van het script moet gesorteerd zijn" {
  output_file=$(mktemp)
  sorted_file=$(mktemp)

  # Schrijf de uitvoer weg naar een bestand
  bash "${script}" > "${output_file}"

  # Sorteer dat bestand en schrijf weg naar een 2e bestand
  sort "${output_file}" > "${sorted_file}"

  # Vergelijk beide, de bestanden moeten identiek zijn
  diff --unified "${output_file}" "${sorted_file}"
}

@test "Controle of enkele standaardgebruikers aanwezig zijn" {

  output_file=$(mktemp)

  # Schrijf de uitvoer weg naar een bestand
  bash "${script}" > "${output_file}"

  # Controleer of de opgegeven gebruikers in het uitvoerbestand staan
  assert_user_exists root   "${output_file}"
  assert_user_exists abrt   "${output_file}"
  assert_user_exists bin    "${output_file}"
  assert_user_exists chrony "${output_file}"
  assert_user_exists daemon "${output_file}"
  assert_user_exists halt   "${output_file}"
  assert_user_exists lp     "${output_file}"
  assert_user_exists mail   "${output_file}"
  assert_user_exists nobody "${output_file}"
}
