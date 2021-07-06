#!/bin/bash

function exportScreens() {
    export LAPTOP=""
    export TOP=""
    export LEFT=""

    redhat="b7a06a0445bf4b91b0d580b52a48bb07"
    perso="52b6b48fd4854afeb74815832a796d0f"
    case "$(cat /etc/machine-id)" in
    "${redhat}")
        export LAPTOP=eDP1
        export TOP=DP3-3
        export LEFT=DP1
        ;;
    "${perso}")
        export LAPTOP=eDP1
        export TOP=HDMI1
        ;;
    esac
}

function _xrandrSingle() {
    exportScreens

    xrandr --verbose --output "${LAPTOP}" --auto
    [[ -n "${TOP}" ]] && xrandr --verbose --output "${TOP}" --off
    [[ -n "${LEFT}" ]] && xrandr --verbose --output "${LEFT}" --off
}
alias xrandrSingle='_xrandrSingle'

function _xrandrDouble() {
    exportScreens

    if [ -z "${TOP}" ]; then
        echo >&2 "You only have a single monitor. Aborting."
        return 1
    fi
    xrandr --verbose \
        --output "${LAPTOP}" --auto \
        --output "${TOP}" --auto --above "${LAPTOP}"
}

alias xrandrDouble='_xrandrDouble'

function _xrandrTriple() {
    exportScreens

    if [ -z "${LEFT}" ]; then
        echo "You only have two monitors. Aborting."
        return 1
    fi
    xrandr --verbose \
        --output "${LAPTOP}" --auto \
        --output "${TOP}" --auto --above "${LAPTOP}" \
        --output "${LEFT}" --auto --left-of "${TOP}"
}

alias xrandrTriple='_xrandrTriple'
