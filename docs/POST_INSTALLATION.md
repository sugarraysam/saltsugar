# Post Installation

Here are some manual steps to execute when you first reboot into your system.

**Install video driver**

Look at the [drivers table on Arch wiki](https://wiki.archlinux.org/title/Xorg#Driver_installation).

```bash
$ lspci -v | grep -A1 -e VGA -e 3D
$ pacman -S <video_driver>
```

**Docking station udev rules**

Add a udev rule to automatically connect Docking station devices:

```bash
cat > /etc/udev/rules.d/99-removable.rules <<EOF

ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"

EOF
```

[**fwupd firmware update**](https://wiki.archlinux.org/title/Fwupd)

You can upgrade some devices firmware, including UEFI using the `fwupd` CLI.

**Look at dmesg for errors and missing firmware**

```bash
$ sudo dmesg | grep -i firmware
$ sudo dmesg | grep -i error
$ sudo dmesg | grep -i warn
```
