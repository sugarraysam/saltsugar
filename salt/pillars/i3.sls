{% set home = grains['sugar']['user_home'] %}

i3:
  pkgs:
    - alacritty # A cross-platform, GPU-accelerated terminal emulator
    - dmenu # Generic menu for X (application launcher)
    - flameshot # Powerful yet simple to use screenshot software
    - i3lock # Improved screenlocker based upon XCB and PAM
    - i3status # Generates status bar to use with i3bar, dzen2 or xmobar
    - i3-wm # An improved dynamic tiling window manager
    - pango # A library for layout and rendering of text
    - pavucontrol # PulseAudio Volume Control
    - pulseaudio # A featureful, general-purpose sound server
    - redshift # Adjusts the color temperature of your screen according to your surroundings.
    - ttf-hack # A hand groomed and optically balanced typeface based on Bitstream Vera Mono.
  dotfiles:
    - {
        src: /srv/salt/i3/dotfiles/i3config,
        dest: {{ home }}/.config/i3/config,
      }
    - {
        src: /srv/salt/i3/dotfiles/i3status.conf,
        dest: {{ home }}/.i3status.conf,
      }
    - {
        src: /srv/salt/i3/dotfiles/redshift.conf,
        dest: {{ home }}/.config/redshift.conf,
      }
    - {
        src: /srv/salt/i3/dotfiles/alacritty.yml,
        dest: {{ home }}/.config/alacritty/alacritty.yml,
      }
