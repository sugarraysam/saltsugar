#!/bin/bash
###
### All aliases should use this format:
###     # <Description of alias>
###     alias <name>="<command>"
###

function fileNotDirOrCurrentFile() {
    [[ -f "${1}" ]] && [[ ! "$1" =~ aliases.sh ]]
}

function sourceAllFilesInDir() {
    for f in "${HOME}"/.zshrc.d/*; do
        if fileNotDirOrCurrentFile "${f}"; then
            source "${f}"
        fi
    done
}

sourceAllFilesInDir
