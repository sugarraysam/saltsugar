#!/bin/bash

function exportScreens() {
    export LAPTOP=""
    export TOP=""
    export LEFT=""

    redhat="b7a06a0445bf4b91b0d580b52a48bb07"
    case "$(cat /etc/machine-id)" in
    "${redhat}")
        export LAPTOP=eDP1
        export TOP=DP3-3
        export LEFT=DP1
        ;;
    esac
}

function _xrandrSingle() {
    exportScreens

    xrandr --verbose --output "${LAPTOP}" --auto
    [[ -n "${TOP}" ]] && xrandr --verbose --output "${TOP}" --off
    [[ -n "${LEFT}" ]] && xrandr --verbose --output "${LEFT}" --off
}
# single display on laptop screen
alias xrandrSingle='_xrandrSingle'

function _xrandrDouble() {
    exportScreens

    xrandr --verbose \
        --output "${LAPTOP}" --auto \
        --output "${TOP}" --auto --above "${LAPTOP}"
}

## two monitors
alias xrandrDouble='_xrandrDouble'

function _xrandrTriple() {
    exportScreens

    xrandr --verbose \
        --output "${LAPTOP}" --auto \
        --output "${TOP}" --auto --above "${LAPTOP}" \
        --output "${LEFT}" --auto --left-of "${LAPTOP}"
}

## three monitors /w 3rd monitor vertical
alias xrandrTriple='_xrandrTriple'
