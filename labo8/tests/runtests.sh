#! /usr/bin/bash
#
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Run BATS test files in the current directory
#
# The script installs BATS if needed. It's best to put ${bats_install_dir} in
# your .gitignore.

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable

#{{{ Variables

test_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bats_archive="v0.4.0.tar.gz"
bats_url="https://github.com/sstephenson/bats/archive/${bats_archive}"
bats_install_dir="${HOME}/.local/opt/bats"
bats="${bats_install_dir}/libexec/bats"

test_file_pattern="*.bats"

# color definitions
Blue='\e[0;34m'
Yellow='\e[0;33m'
Reset='\e[0m'

#}}}

main() {
  install_shellcheck_if_needed
  install_bats_if_needed

  # List all test cases (i.e. files in the test dir matching the test file
  # pattern)
  global_tests=$(find_tests "${test_dir}")

  # Loop over test files
  for test_case in ${global_tests}; do
    echo -e "${Blue}Running test ${Yellow}${test_case}${Reset}"
    ${bats} "${test_case}"
  done
}

#{{{ Functions

# Usage: install_shellcheck_if_needed
install_shellcheck_if_needed() {
  if ! which shellcheck > /dev/null 2>&1; then
    echo "Installing package ‘ShellCheck’. Please enter your sudo password!"
    sudo dnf install -y ShellCheck
  fi
}

# Usage: install_bats_if_needed
install_bats_if_needed() {
  parent_dir="${bats_install_dir%/*}"
  if [ ! -d "${parent_dir}" ]; then
    mkdir -p "${parent_dir}"
  fi
  pushd "${parent_dir}" > /dev/null
  if [[ ! -d "${bats_install_dir}" ]]; then
    wget "${bats_url}"
    tar xf "${bats_archive}"
    mv bats-* bats
    rm "${bats_archive}"
  fi
  popd > /dev/null
}

# find_tests DIR [MAX_DEPTH]
find_tests() {
  local max_depth=""
  if [ "$#" -eq "2" ]; then
    max_depth="-maxdepth $2"
  fi

  local tests
  tests=$(find "$1" "${max_depth}" -type f -name "${test_file_pattern}" -printf '%p\n' 2> /dev/null)

  echo "${tests}" | sort
}
#}}}

main "${@}"
