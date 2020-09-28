#! /usr/bin/env bats
# Unit test voor Labo 6 (deel 2): passphrase.sh

#
# Variables
#

# Script Under Test
script=./passphrase.sh
custom_dict=./custom.dict

#
# Helper functions
#

# Create a custom dictionary
create_dict() {
cat >| "${custom_dict}" << EOF
a
b
c
d
e
f
g
EOF
}

# Remove the custom dictionary
rm_dict() {
  rm "${custom_dict}"
}

#
# Test cases
#

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
  bash -n ${script}
}

@test "Controle of de standaard woordenlijst (/usr/share/dict/words) bestaat" {
  [ -f /usr/share/dict/words ]
}

@test "Toon een hulpboodschap (Usage:) als je het script oproept met -h" {
  result="$(${script} -h)"
  [ -n "$(echo "${result}" | grep '^Usage:.*')" ]
}

@test "Toon een hulpboodschap (Usage:) als je het script oproept met -?" {
  result="$(${script} -?)"
  [ -n "$(echo "${result}" | grep '^Usage:.*')" ]
}

@test "Toon een hulpboodschap (Usage:) als je het script oproept met --help" {
  result="$(${script} --help)"
  [ -n "$(echo "${result}" | grep '^Usage:.*')" ]
}

@test "Argumenten na -h moeten genegeerd worden" {
  result="$(${script} -h stuff)"
  [ -n "$(echo "${result}" | grep '^Usage:.*')" ]
}

@test "Sluit af met e exit status 2 bij 3 of meer argumenten" {
  run ${script} with too many arguments
  [ "${lines[0]}" = "Expected at most 2 arguments, got 4" ]
  [ "${status}" -ne 0 ]
}

@test "Zonder argumenten. geef een wachtwoordzin van vier woorden" {
  result="$(${script} | wc --words)"
  [ "${result}" -eq 4 ]
}

# Call the script with the specified number as argument and check the
# number of words in the output is the same
# $1 - number of words to output
test_set_num_words () {
  result="$(${script} $1 | wc --words)"
  [ "${result}" -eq $1 ]
}

@test "Een opgegeven aantal woorden moet gerespecteerd worden" {
  for i in {1..10}; do
    test_set_num_words $i
  done
}

@test "Gebruik een opgegeven woordenlijst" {
  create_dict

  result="$(${script} ${custom_dict})"
  # result should contain exactly four letters that occur in the
  # custom dictionary
  match=$(echo "${result}" | egrep '([a-g]\ ?){4}')
  [ -n "${match}" ]

  num="$(echo ${result} | wc --words)"
  [ "${num}" -eq 4 ]

  rm_dict
}

@test "Geef het aantal woorden én een woordenlijst op" {
  create_dict

  result="$(${script} 3 ${custom_dict})"
  # result should contain exactly 3 letters that occur in the
  # custom dictionary
  match=$(echo "${result}" | egrep '([a-g]\ ?){3}')
  [ -n "${match}" ]

  num="$(echo ${result} | wc --words)"
  [ "${num}" -eq 3 ]

  rm_dict
}

@test "Sluit af met een fout als de opgegeven woordenlijst niet bestaat" {
  run ${script} /path/to/nonexisting/file
  [ "${status}" -ne "0" ]
}

@test "Een wachtwoordzin moet op één lijn komen" {
  result="$(${script} | wc --lines)"
  [ "${result}" -eq 1 ]
}


