#! /usr/bin/env bats
#
# Unit test voor Labo 6 (deel 2): backup.bats

#
# Variables
#

# Script Under Test
script=./backup.sh

dir=./dir

#
# Helper functions
#

# Create a directory
setup() {
  mkdir -p ${dir}/a/{b,c}/d
  touch ${dir}/file1 ${dir}/file2
  touch ${dir}/a/file3 ${dir}/a/file4
  touch ${dir}/a/b/file5 ${dir}/a/c/file6
  touch ${dir}/a/b/d/file7 ${dir}/a/c/d/file8
}

# Remove the directory
teardown() {
  rm -rf "${dir}"
  rm -rf "/tmp/tmp.*"
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

@test "Backup naar de standaardlocatie (/tmp)" {
  target_dir=/tmp
  timestamp=$(date +%Y%m%d%H%M)
  archive="${target_dir}/$(basename ${dir})-${timestamp}.tar.bz2"
  log="${target_dir}/backup-${timestamp}.log"

  # Perform the backup:
  ${script} "${dir}"

  # Archive should be a file, containing bzip2 data and have 14 files
  # inside
  [ -f "${archive}" ]
  [ -n "$(file ${archive} | grep 'bzip2 compressed data')" ]
  [ "$(tar tjf ${archive} | wc --lines)" -eq "14" ]

  # The log file should be there, contain ASCII text and not be empty
  [ -f "${log}" ]
  [ -n "$(file ${log} | grep 'ASCII text')" ]
  [ "$(stat --format=%s ${log})" -gt "0" ]

  # Cleanup (not part of the actual test)
  rm "${archive}"
  rm "${log}"
}

@test "Backup naar een opgegeven locatie met optie -d" {
  target_dir=$(mktemp --directory)
  timestamp=$(date +%Y%m%d%H%M)
  archive="${target_dir}/$(basename ${dir})-${timestamp}.tar.bz2"
  log="${target_dir}/backup-${timestamp}.log"

  # Perform the backup:
  ${script} -d ${target_dir} "${dir}"

  # Archive should be a file, containing bzip2 data and have 14 files
  # inside
  [ -f "${archive}" ]
  [ -n "$(file ${archive} | grep 'bzip2 compressed data')" ]
  [ "$(tar tjf ${archive} | wc --lines)" -eq "14" ]

  # The log file should be there, contain ASCII text and not be empty
  [ -f "${log}" ]
  [ -n "$(file ${log} | grep 'ASCII text')" ]
  [ "$(stat --format=%s ${log})" -gt "0" ]

  # Cleanup (not part of the actual test)
  rm "${archive}"
  rm "${log}"
  rmdir "${target_dir}"
}

@test "Backup naar een opgegeven locatie met optie --destination" {
  target_dir=$(mktemp --directory)
  timestamp=$(date +%Y%m%d%H%M)
  archive="${target_dir}/$(basename ${dir})-${timestamp}.tar.bz2"
  log="${target_dir}/backup-${timestamp}.log"

  # Perform the backup:
  ${script} --destination ${target_dir} "${dir}"

  # Archive should be a file, containing bzip2 data and have 14 files
  # inside
  [ -f "${archive}" ]
  [ -n "$(file ${archive} | grep 'bzip2 compressed data')" ]
  [ "$(tar tjf ${archive} | wc --lines)" -eq "14" ]

  # The log file should be there, contain ASCII text and not be empty
  [ -f "${log}" ]
  [ -n "$(file ${log} | grep 'ASCII text')" ]
  [ "$(stat --format=%s ${log})" -gt "0" ]

  # Cleanup (not part of the actual test)
  rm "${archive}"
  rm "${log}"
  rmdir "${target_dir}"
}

@test "‘${script} -d’ moet afsluiten met een fout" {
  run ${script} -d
  [ "0" -ne "${status}" ]
}
@test "‘${script} -a’ moet afsluiten met een fout" {
  run ${script} -a
  [ "0" -ne "${status}" ]
}

@test "‘${script} -d /nosuchdir’ moet afsluiten met een fout" {
  run ${script} -d /nosuchdir
  [ "0" -ne "${status}" ]
}

@test "‘${script} /nosuchdir’ moet afsluiten met een fout" {
  run ${script} /nosuchdir
  [ "0" -ne "${status}" ]
}



