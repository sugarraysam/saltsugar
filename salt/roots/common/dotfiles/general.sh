#!/bin/bash
###
### # <Description of alias>
### alias <name>="<command>"
###

# shortcut for archsugar + fix completions
alias sug="archsugar"
complete -F __start_archsugar sug

# Replace ls with lsf
alias ls="lsd"

# Use l instead of ls
alias l="lsd -lah"

# Replace cat with bat
alias cat="bat"

# Source ~/.zshrc
alias srcz="source ~/.zshrc"

# $ timecmd CMD [ARGS...] -- Calcule how many seconds CMD takes to execute
alias timecmd='f(){ START=$SECONDS; $@; ELAPSED=$(( $SECONDS - $START )); echo "Elapsed: $ELAPSED sec";};f'

# tcpdump
alias tcpdump="sudo tcpdump -Z sugar"

# $ getprocessfromport PORT -- use lsof to retrieve process listening on TCP port
alias getProcessfromTCPport='f(){ sudo lsof -iTCP:$1 -sTCP:LISTEN ;};f'

# output all terminal colors
alias printTerminalColors='for c in {0..255}; do tput setab $c; echo "decimal: $c"; done; tput sgr0; echo'

# shortcut for gopass show -c
alias pass="gopass show -c"

# VBoxManage friendly alias
alias vbox="VBoxManage"

# use --auto-rotate on feh by default
alias feh="feh --auto-rotate"

# set watch default interval to 1 second
alias watch="watch -n 1"
