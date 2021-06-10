# Post Installation

Here are some manual steps to execute when you first reboot into your system.

**Install video driver**

Look at the [drivers table on Arch wiki](https://wiki.archlinux.org/title/Xorg#Driver_installation).

```bash
$ lspci -v | grep -A1 -e VGA -e 3D
$ pacman -S <video_driver>
```

**Docking station udev rules**

_TODO_
