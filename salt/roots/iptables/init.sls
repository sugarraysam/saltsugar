iptables_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['iptables']['pkgs'] }}

iptables_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['iptables']['dotfiles'] }}

iptables_v4:
  service.running:
    - name: iptables
    - enable: True
    - watch:
      - sugfile: iptables_symlink_dotfiles

iptables_v6:
  service.running:
    - name: ip6tables
    - enable: True
    - watch:
      - sugfile: iptables_symlink_dotfiles
