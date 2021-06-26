refresh_grains:
  module.run:
    - name: saltutil.refresh_grains
    - reload_grains: true

# Run this as very last state to inform user if kernel was upgraded and a reboot is required.
notify_user_to_reboot:
  cmd.run:
    - name: |
        cat <<EOF
         ___________________________________
         < Kernel upgraded. Please reboot. >
         -----------------------------------
                \   ^__^
                 \  (oo)\_______
                    (__)\       )\/\/
                        ||----w |
                        ||     ||
        EOF
    - unless: "ls /lib/modules/{{ grains['kernelrelease'] }}"
    - order: last
    - require:
      - module: refresh_grains
