#!/bin/bash

set -x
set -e

###
### Functions
###
# Make sure there will be enough space on the live ISO
function resizeRootfs() {
    if [ -d /run/archiso ]; then
        mount -o remount,size=5G /run/archiso/cowspace
    fi
}

function pacmanInit() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Syy --noconfirm
    pacman -S --noconfirm --needed archlinux-keyring
    pacman -S --noconfirm --needed pacman
}

function installPacmanDeps() {
    pkgs=(
        parted
        util-linux # provides lsblk
    )
    pacman --noconfirm -S --needed "${pkgs[@]}"
}

function validateDisk() {
    disks=$(lsblk -n -o PATH)
    if [ -z "${BOOTSTRAP_DISK}" ]; then
        echo 2>&1 "Invalid empty disk."
        echo 2>&1 "Please set the BOOTSTRAP_DISK env var."
        exit 1
    elif ! echo "${disks}" | grep "${BOOTSTRAP_DISK}" >/dev/null; then
        echo 2>&1 "Disk ${BOOTSTRAP_DISK} does not exist. Please select one of:"
        echo 2>&1 "${disks}"
        exit 1
    fi
}

# https://wiki.archlinux.org/title/Parted#UEFI/GPT_examples
function partition() {
    echo "Partitioning disk ${BOOTSTRAP_DISK}..."
    parted -s "${BOOTSTRAP_DISK}" mklabel gpt

    # Partition names need to be a single word (e.g: EFI, ROOT)
    # Create EFI partition
    parted -s "${BOOTSTRAP_DISK}" mkpart "EFI" fat32 1MiB 261MiB
    parted -s "${BOOTSTRAP_DISK}" set 1 esp on

    # Create root partition
    parted -s "${BOOTSTRAP_DISK}" mkpart "ROOT" 261MiB 100%
}

function cryptsetup() {
    echo "NOT IMPLEMENTED"
}

###
### Run
###
# init
resizeRootfs
pacmanInit
installPacmanDeps

# disk
validateDisk
partition
#cryptsetup - TODO rendu ici

#reboot # uncomment..reboot at very end
