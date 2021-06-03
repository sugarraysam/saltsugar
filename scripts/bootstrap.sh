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

function pacmanKeys() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --updatedb
    pacman -Sy --noconfirm
}

function pacmanDeps() {
    pkgs=(
        parted
        reflector
        util-linux # provides lsblk
    )
    pacman --noconfirm -S --needed "${pkgs[@]}"
}

function pacmanMirrors() {
    reflector --country 'United States' \
        --latest 24 \
        --age 20 \
        --sort rate \
        --protocol http \
        --protocol https \
        --save /etc/pacman.d/mirrorlist
}

function validateDisk() {
    if [ -z "${BOOTSTRAP_DISK}" ]; then
        echo >&2 "Invalid empty disk."
        echo >&2 "Please set the BOOTSTRAP_DISK env var."
        exit 1
    elif [ ! -b "${BOOTSTRAP_DISK}" ]; then
        echo >&2 "Disk ${BOOTSTRAP_DISK} does not exist. Please select one of:"
        lsblk -n o PATH >&2
        exit 1
    fi
}

# https://wiki.archlinux.org/title/Parted#UEFI/GPT_examples
function partition() {
    echo "Partitioning disk ${BOOTSTRAP_DISK}..."
    parted -s "${BOOTSTRAP_DISK}" mklabel gpt

    # Partition names need to be a single word (e.g: EFI, ROOT)
    # Create EFI partition
    parted -s "${BOOTSTRAP_DISK}" mkpart "EFI" 1MiB 261MiB
    parted -s "${BOOTSTRAP_DISK}" set 1 esp on

    # Create root partition
    parted -s "${BOOTSTRAP_DISK}" mkpart "ROOT" 261MiB 100%

}

function exportPartitions() {
    if [ -b "${BOOTSTRAP_DISK}1" ]; then
        export BOOT_PART="${BOOTSTRAP_DISK}1"
        export ROOT_PART="${BOOTSTRAP_DISK}2"
    elif [ -b "${BOOTSTRAP_DISK}p1" ]; then
        export BOOT_PART="${BOOTSTRAP_DISK}p1"
        export ROOT_PART="${BOOTSTRAP_DISK}p2"
    else
        echo >&2 "Unsupported partition name, partition neither ends with 1 or p1."
        echo >&2 "Modify script to support partition listed here:"
        ls ${BOOTSTRAP_DISK}* >&2
        exit 1
    fi
    echo "Exported BOOT_PART=${BOOT_PART} and ROOT_PART=${ROOT_PART}."
}

function encryptDisk() {
    echo "Encrypting root partition ${ROOT_PART} with cryptsetup..."
    if [ -z "${BOOTSTRAP_LUKS}" ]; then
        echo >&2 "Please set BOOTSTRAP_LUKS."
        exit 1
    fi
    # Encrypting devices with cryptsetup
    # https://wiki.archlinux.org/title/Dm-crypt/Device_encryption#Encrypting_devices_with_cryptsetup
    echo ${BOOTSTRAP_LUKS} >/dev/shm/luks
    cryptsetup luksFormat ${ROOT_PART} /dev/shm/luks
    cryptsetup --key-file=/dev/shm/luks open ${ROOT_PART} sugarcrypt
    export CRYPT_PART=/dev/mapper/sugarcrypt
    echo "Exported CRYPT_PART=${CRYPT_PART}."
    rm /dev/shm/luks
}

function mountFs() {
    echo "Mounting ${CRYPT_PART} + ${BOOT_PART}..."
    mkfs.btrfs ${CRYPT_PART}
    mount -t btrfs ${CRYPT_PART} /mnt

    mkdir -p /mnt/boot
    mkfs.vfat -F 32 ${BOOT_PART}
    mount -t vfat ${BOOT_PART} /mnt/boot
}

# Pacstrap copies the host's:
#   - Keyring => /etc/pacman.d/gnupg
#   - Mirrors => /etc/pacman.d/mirrorlist
function runPacstrap() {
    echo "Running pacstrap..."
    pkgs=(
        base
        base-devel
        btrfs-progs
        curl
        dhclient
        efibootmgr
        git
        gnupg
        grub
        linux
        linux-firmware
        man
        mkinitcpio
        networkmanager
        openssh
        reflector
        sudo
        vi
        vim
        xclip
        zsh
    )
    pacstrap -c /mnt "${pkgs[@]}"
    genfstab -U -p /mnt >/mnt/etc/fstab
}

# Chroot does not see the file if placed in /tmp/
function copyAndRunChroot() {
    echo "Copying and running chroot.sh script..."
    cp ${PWD}/scripts/chroot.sh /mnt/root/chroot.sh
    chmod +x /mnt/root/chroot.sh
    arch-chroot /mnt /root/chroot.sh
    rm /mnt/root/chroot.sh
}

###
### Run
###
resizeRootfs

# pacman
pacmanKeys
pacmanDeps
pacmanMirrors

# disk + filesystems
validateDisk
partition
exportPartitions
encryptDisk
mountFs

# chroot
runPacstrap
copyAndRunChroot

echo "Congratulations! Please reboot into your new system."
echo "Congratulations! Please reboot into your new system."
echo "Congratulations! Please reboot into your new system."
echo "Congratulations! Please reboot into your new system."
echo "Congratulations! Please reboot into your new system."
