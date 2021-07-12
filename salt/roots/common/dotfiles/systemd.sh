#!/bin/bash

# systemctl sudo wrapper
alias ctl="sudo systemctl"

# unit status
alias ctlstat="systemctl status"

# journalctl sudo wrapper
alias ctljour="sudo journalctl"

# list all failed units
alias ctlLsFailed="sudo systemctl list-units --state=failed"
