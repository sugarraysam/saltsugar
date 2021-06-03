#!/bin/bash

# iptables sudo wrapper
alias iptables="sudo iptables"

# ip6tables sudo wrapper
alias ip6tables="sudo ip6tables"

# list default 'filter' table (add -t <table> to view another table)
alias iptablist="sudo iptables -vnL --line-numbers"
alias ip6tablist="sudo ip6tables -vnL --line-numbers"
