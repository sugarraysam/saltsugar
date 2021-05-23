#!/bin/bash

export BASE_PKGS=(
    git
    make
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

function configureZsh() {
    chsh --shell /usr/bin/zsh vagrant
}

function setWorkdir() {
    for f in .zprofile .bash_profile; do
        path="/home/vagrant/${f}"
        echo "cd /vagrant" >>${path}
        chown vagrant:vagrant ${path}
    done
}

###
### Run
###
pacmanInit
installBasePkgs
configureZsh
setWorkdir
