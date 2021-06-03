#!/bin/bash

# single display on laptop screen
alias xrandrSingle="xrandr --output eDP1 --auto --output HDMI1 --off"

# two monitors with HDMI
alias xrandrHDMI="xrandr --output eDP1 --auto --output HDMI1 --auto --above eDP1"
