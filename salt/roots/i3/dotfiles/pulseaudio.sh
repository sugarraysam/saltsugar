#!/bin/bash

# clean pulseaudio files and restart daemon
function _pulseRestart() {
    rm -fr ~/.config/pulse /tmp/pulse-* >/dev/null 2>&1 || true
    systemctl --user restart pulseaudio.service
}
alias pulseRestart="_pulseRestart"
