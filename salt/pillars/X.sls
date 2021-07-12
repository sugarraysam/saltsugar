{% set home = grains['sugar']['home'] %}

X:
  pkgs:
    - xorg-server # Xorg X server
    - xorg-xrandr # Primitive command line interface to RandR extension
    - xorg-xprop # Property displayer for X (used /w i3 to set default window for a program)
    - xorg-xinit # X.Org initialisation program
    - xorg-xauth # X.Org authorization settings program (manipulate ~/.Xauthority)
    - xorg-xset # User preference utility for X (used in .xinitrc for power saving options)
    - xorg-xbacklight # RandR-based backlight control application
    - xorg-xinput # Small commandline tool to configure devices
  dotfiles:
    - {
        src: /srv/salt/X/dotfiles/00-custom.conf,
        dest: /etc/X11/xorg.conf.d/00-custom.conf,
        user: root,
        group: root,
      }
    - {
        src: /srv/salt/X/dotfiles/xinitrc,
        dest: {{ home }}/.xinitrc,
      }
    - {
        src: /srv/salt/X/dotfiles/xserverrc,
        dest: {{ home }}/.xserverrc,
      }
    - {
        src: /srv/salt/X/dotfiles/X.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/X.sh,
      }
  xkbmodel_cmd: "setxkbmap -query | grep model | awk '{ print $2 }'"
