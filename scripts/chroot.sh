#!/bin/bash

set -x
set -e

###
### Functions
###
function setupClock() {
    ln -sf "/usr/share/zoneinfo/${BOOTSTRAP_TZ}" /etc/localtime
    hwclock --systohc
}

function setupLanguages() {
    sed -i "s/^#en_CA.*$/en_CA.UTF8 UTF-8/" /etc/locale.gen
    sed -i "s/^#en_US.*$/en_US.UTF8 UTF-8/" /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" >/etc/locale.conf
}

function setupUsers() {
    useradd --shell /usr/bin/zsh \
        --create-home \
        --groups wheel,uucp "${BOOTSTRAP_USER}"
    echo -e "${BOOTSTRAP_USER_PASSWD}\n${BOOTSTRAP_USER_PASSWD}" | passwd ${BOOTSTRAP_USER}
    echo -e "${BOOTSTRAP_ROOT_PASSWD}\n${BOOTSTRAP_ROOT_PASSWD}" | passwd root

    cat >"/etc/sudoers.d/${BOOTSTRAP_USER}" <<EOF
${BOOTSTRAP_USER} ALL=(ALL) ALL
Defaults:${BOOTSTRAP_USER}    env_keep += "HTTP_PROXY HTTPS_PROXY FTP_PROXY", timestamp_timeout = 15
EOF
}

function pacmanHooks() {
    mkdir -p /etc/pacman.d/hooks
    cat >/etc/pacman.d/hooks/mirrorupgrade.hook <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = pacman-mirrorlist

[Action]
Description = Updating pacman-mirrorlist with reflector and removing pacnew...
When = PostTransaction
Depends = reflector
Exec = /bin/sh -c "reflector -c 'United States' -l 24 -a 20 --sort rate -p http -p https --save /etc/pacman.d/mirrorlist; rm -f /etc/pacman.d/mirrorlist.pacnew"
EOF
}

function setHostname() {
    echo "${BOOTSTRAP_HOSTNAME}" >/etc/hostname
}

function setupNetworkManager() {
    mkdir -p /etc/NetworkManager/conf.d
    cat >/etc/NetworkManager/conf.d/10-dhclient.conf <<EOF
[main]
dhcp=dhclient
EOF
    cat >/etc/NetworkManager/conf.d/20-dns.conf <<EOF
# https://wiki.archlinux.org/index.php/NetworkManager#systemd-resolved
[main]
dns=systemd-resolved
EOF
    cat >/etc/NetworkManager/conf.d/30-mac-randomization.conf <<EOF
# https://wiki.archlinux.org/index.php/NetworkManager#Configuring_MAC_address_randomization
[device-mac-randomization]
# "yes" is already the default for scanning
wifi.scan-rand-mac-address=yes

[connection-mac-randomization]
# Randomize MAC for every ethernet connection
ethernet.cloned-mac-address=random
# Generate a random MAC for each WiFi and associate the two permanently.
wifi.cloned-mac-address=stable
EOF
    systemctl enable NetworkManager
    systemctl enable systemd-resolved
    systemctl disable systemd-networkd
}

function hibernateKeySuspends() {
    sed -i "s/^#HandleHibernateKey.*$/HandleHibernateKey=suspend/" /etc/systemd/logind.conf
}

function setupSwapFile() {
    # Special commands for btrfs
    # https://wiki.archlinux.org/index.php/Swap#Swap_file
    truncate -s 0 /swapfile
    chattr +C /swapfile
    btrfs property set /swapfile compression none

    dd if=/dev/zero of=/swapfile bs=1M count="${BOOTSTRAP_SWAP_SIZE_MB}"
    chmod 0600 /swapfile
    mkswap /swapfile
    echo "/swapfile none swap sw 0 0" >>/etc/fstab
}

# We need to setup initramfs before bootloader to avoid potential mistakes
function setupInitramfs() {
    echo "Setting up initramfs..."
    if grep -i intel /proc/cpuinfo; then
        pacman -q -S --noconfirm --needed intel-ucode
        export CPU_MANUFACTURER=intel
    else
        pacman -q -S --noconfirm --needed amd-ucode
        export CPU_MANUFACTURER=amd
    fi
    hooks="base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck"
    sed -i "s/^HOOKS=.*/HOOKS=(${hooks})/" /etc/mkinitcpio.conf
    mkinitcpio -P
}

function setupGrub() {
    if [ ! -d "/sys/firmware/efi/efivars" ]; then
        echo >&2 "UEFI variables not accessible. Did the system boot in UEFI mode?"
        exit 1
    fi
    # Install UEFI bootloader to /boot/EFI/GRUB/grubx64.efi
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

    # Set kernel parameters so GRUB can unlock encrypted root partition
    # https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_the_boot_loader
    # https://wiki.archlinux.org/title/Dm-crypt/System_configuration#Boot_loader
    # https://wiki.archlinux.org/title/Kernel_parameters#GRUB
    uuid=$(blkid -s UUID -o value ${ROOT_PART})
    line="quiet splash cryptdevice=UUID=${uuid}:${BOOTSTRAP_DMNAME} root=/dev/mapper/${BOOTSTRAP_DMNAME}"
    sed -i "s,^GRUB_CMDLINE_LINUX_DEFAULT=.*,GRUB_CMDLINE_LINUX_DEFAULT=\"${line}\"," /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

function cloneSaltSugar() {
    dest="/home/${BOOTSTRAP_USER}/opt/"
    mkdir -p "${dest}"
    git clone https://github.com/sugarraysam/saltsugar.git "${dest}/saltsugar"
    chown -R "${BOOTSTRAP_USER}:${BOOTSTRAP_USER}" "${dest}/saltsugar"
}

###
### Run
###
setupClock
setupLanguages
setupUsers
pacmanHooks
setHostname
setupNetworkManager
hibernateKeySuspends
setupSwapFile

# Bootloader
setupInitramfs
setupGrub

cloneSaltSugar
