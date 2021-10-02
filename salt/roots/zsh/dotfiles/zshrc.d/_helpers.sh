#!/bin/bash
RED=1
GREEN=2
YELLOW=3

_err_msg() {
    echo >&2 "$(
        tput bold
        tput setaf ${RED}
    )[-] ERROR: ${*}$(tput sgr0)"
}

_warn_msg() {
    echo >&2 "$(
        tput bold
        tput setaf ${YELLOW}
    )[!] WARNING: ${*}$(tput sgr0)"
}
