clean_pacman_cache:
  cmd.run:
    - name: pacman --noconfirm -q -Sc

remove_orphan_packages:
  cmd.run:
    - unless: pacman -Qtdq # returns 1 if there are no orphan pkgs
    - name: "pacman -Rns --noconfirm $(pacman -Qtdq)"

enable_pacman_colors:
  file.uncomment:
    - name: /etc/pacman.conf
    - regex: "^#Color.*$"
    - char: "#"
