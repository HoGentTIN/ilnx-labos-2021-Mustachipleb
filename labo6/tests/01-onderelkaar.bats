#! /usr/bin/env bats
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Testscript voor opgave Labo 6 ‘onderelkaar.sh’

script="onderelkaar.sh"

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

@test "Commando ‘xxd’ is beschikbaar. Indien niet, doe eerst ‘sudo dnf install -y vim-enhanced’" {
  which xxd
}

##
# In de volgende tests wordt de uitvoer van het script telkens naar "xxd"
# gestuurd. Dit commando geeft een hexdump van de uitvoer van het script, wat
# het makkelijker maakt om te controleren of het resultaat klopt. In Bash
# is het immers moeilijk om strings met speciale karakters en newlines te
# vergelijken.
#
# vb. e -> 65, newline (\r) -> 0a, spatie -> 20, enz.

@test "./${script} een             => ‘een\r’" {
  result="$(bash ${script} een | xxd -plain)"
  echo -e "result was: ${result}"
  #                e e n \r
  [ "${result}" = '65656e0a' ]
}

@test "./${script} een twee        => ‘een\rtwee\r’" {
  result="$(bash ${script} een twee | xxd -plain)"
  echo -e "result was: ${result}"
  #                e e n \rt w e e \r
  [ "${result}" = '65656e0a747765650a' ]
}

@test "./${script} een twee drie   => ‘een\rtwee\rdrie’" {
  result="$(bash ${script} een twee drie | xxd -plain)"
  echo -e "result was: ${result}"
  #                e e n \rt w e e \rd r i e \r
  [ "${result}" = '65656e0a747765650a647269650a' ]
}

@test "./${script} een .. vijftien => ‘een\r...\rvijftien’ (meer dan 10 argumenten)" {
  result="$(bash ${script} een twee drie vier vijf zes zeven acht negen tien elf twaalf dertien veertien vijftien | xxd -c 256 -plain)"
  echo -e "result was: ${result}"
  [ "${result}" = '65656e0a747765650a647269650a766965720a76696a660a7a65730a7a6576656e0a616368740a6e6567656e0a7469656e0a656c660a747761616c660a6465727469656e0a766565727469656e0a76696a667469656e0a' ]
}

@test "./${script} een \"twee drie\" => ‘een\rtwee drie’ (argument met spatie)"  {
  result="$(bash ${script} een "twee drie" | xxd -plain)"
  echo -e "result was: ${result}"
  #                e e n \rt w e e   d r i e \r
  [ "${result}" = '65656e0a7477656520647269650a' ]
}

@test "Geen argumenten => fout" {
  run bash ${script}
  [ "${status}" -ne '0' ]  # De exit status moet != 0 zijn
  [ "${output}" != '' ]    # Er moet een foutboodschap afgedrukt worden
}

