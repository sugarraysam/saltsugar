#!/bin/bash

# Docker
alias doc="docker"
alias doclft="docker logs -ft"
alias docexsh='f(){ docker exec -it "$1" /bin/sh };f'
alias docstopa='docker stop $(docker ps -aq)'
alias docrma='docker rm -f $(docker ps -aq)'
alias docrm='f(){ docker rm -f $(docker ps -aqf name=$1) };f'
alias docpsa='docker ps -a'
alias wdocpsa='watch docker ps -a'
