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
        export TOP="$(xrandr -q | grep ' connected' | awk '{print $1}' | grep -v ${LAPTOP})"
        ;;
    "${perso}")
        export LAPTOP=eDP1
        export TOP=HDMI1
        ;;
    esac
}

function listActiveMonitors() {
    xrandr --listactivemonitors | tail -n +2 | awk '{print $2}'
}

function _xrandrSingle() {
    exportScreens
    xrandr --verbose --output "${LAPTOP}" --auto

    # turn off all other active monitors
    for monitorRaw in $(listActiveMonitors); do
        monitor="${monitorRaw#+}"
        monitor="${monitor#\*}"
        if [ "${monitor}" != "${LAPTOP}" ]; then
            xrandr --output "${monitor}" --off
        fi
    done
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
