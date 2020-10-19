#! /bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

penguin='Tux'

#printf '%s\n' "${BASH_VERSION}" "${penguin}"

export penguin

#/home/mustachio/scripts/variabelen-subshell.sh

#printf '%s\n' "${BASH_SUBSHELL}"; (printf '%s\n' "${BASH_SUBSHELL}" "${penguin}")

declare -a array
array=(${PATH} ${HISTSIZE} ${UID} ${HOME} ${HOSTNAME} ${LANG} ${USER} ${OSTYPE} ${PWD})

printf '%s\n' "${array[@]}"
