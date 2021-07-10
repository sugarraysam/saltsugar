{% if grains['sugar']['vtx_enabled'] %}

vbox_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['vbox']['pkgs'] }}

delete_default_machine_folder:
  file.absent:
    - name: "{{ grains['sugar']['home'] }}/VirtualBox VMs"
    - require:
      - pkg: vbox_pkgs

create_machine_folder:
  file.directory:
    - name: {{ pillar['vbox']['machine_folder_path'] }}
    - user: {{ grains['sugar']['user'] }}
    - group: {{ grains['sugar']['user'] }}
    - mode: 0775

# CoW needs to be disabled where hard disk images will be stored because filesystem is btrfs
# https://wiki.archlinux.org/index.php/QEMU#Creating_new_virtualized_system
# https://wiki.archlinux.org/index.php/Btrfs#Copy-on-Write_(CoW)
disable_cow_machine_folder:
  cmd.run:
    - name: chattr +C {{ pillar['vbox']['machine_folder_path'] }}
    - require:
      - file: create_machine_folder

set_machine_folder:
  cmd.run:
    - name: VBoxManage setproperty machinefolder {{ pillar['vbox']['machine_folder_path'] }}
    - require:
      - pkg: vbox_pkgs
      - cmd: disable_cow_machine_folder

{% endif %}
