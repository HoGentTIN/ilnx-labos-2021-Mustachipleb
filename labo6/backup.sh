#!/bin/bash
# 11. Dit is dus niet schoon, maar het werkt dus ¯\_(ツ)_/¯

show_help() {
    echo '- Opties en argumenten:'
    echo '- `-h|-?|--help`: druk uitleg over het commando af en sluit af met exit-status 0. Eventuele andere opties en argumenten worden genegeerd.'
    echo '- `-d|--destination DIR`: de directory waar de backup naartoe geschreven moet worden. Standaardwaarde is `/tmp`'
    echo '- `DIR` de directory waarvan er een backup gemaakt moet worden. Standaardwaarde is de home-directory van de huidige gebruiker.'
}

backup() {
    tar cfvj $backupdir$(basename $srcpath)-$(date +%Y%m%d%H%M).tar.bz2 $srcpath &> backup-$(date +%Y%m%d%H%M).log
}

if [[ $# > 3 ]]; then
    echo 'Te veel argumenten'
    exit 1
fi

backupdir="/tmp"
optspec=":h?d-:"
while getopts "$optspec" optchar; do
    case "$optchar" in
        -)
            case "${OPTARG}" in
                help)
                    show_help
                    exit 0
                    ;;
                destination)
                    val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                    shift 2
                    backupdir=$val
                    ;;
            esac;;
        h|\?)
            show_help
            exit 0
            ;;
        d)
            val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
            shift 2
            backupdir=${val}
            ;;
    esac
done
srcpath=$1
backup