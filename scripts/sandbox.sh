#!/bin/bash

export BASE_PKGS=(
    git
    vim
    salt
    which
    zsh
    zsh-completions
)

function pacmanInit() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Syy --noconfirm
    pacman -S --noconfirm --needed archlinux-keyring
    pacman -S --noconfirm --needed pacman
}

function installBasePkgs() {
    for p in "${BASE_PKGS[@]}"; do
        pacman --noconfirm -S --needed "${p}"
    done
}

function copyEtcMinion() {
    mkdir -p /etc/salt/
    cp /tmp/minion /etc/salt/minion
}

function configureZsh() {
    chsh --shell /usr/bin/zsh vagrant
}

###
### Run
###
pacmanInit
installBasePkgs
copyEtcMinion
configureZsh
