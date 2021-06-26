clean_pacman_cache:
  cmd.run:
    - name: pacman --noconfirm -q -Sc

remove_orphan_packages:
  cmd.script:
    - name: salt://common/scripts/remove_orphan_packages.sh

enable_pacman_colors:
  file.uncomment:
    - name: /etc/pacman.conf
    - regex: "Color.*$"
    - char: "#"

update_kernel:
  cmd.run:
    - name: pacman -Syu --noconfirm -q
    - order: last
