#!/bin/bash

function getScreens() {
    xrandr -q | grep -w connected | awk '{ print $1 }' | tr '\n' ' '
}

function _xrandrSingle() {
    laptop="${1}"
    for output in $(xrandr -q | grep connected | awk '{ print $1 }'); do
        if [ ! "${output}" = "${laptop}" ]; then
            xrandr --output "${output}" --off
        fi
    done
    xrandr --output "${laptop}" --auto
}

function _xrandrHDMI() {
    laptop="${1}"
    hdmi="${2}"
    xrandr --output "${laptop}" --auto --output "${hdmi}" --auto --above "${laptop}"
}

# single display on laptop screen
alias xrandrSingle='_xrandrSingle $(getScreens)'

## two monitors with HDMI
alias xrandrHDMI='_xrandrHDMI $(getScreens)'
