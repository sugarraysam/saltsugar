i3_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['i3']['pkgs'] }}

i3_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['i3']['dotfiles'] }}

# Required otherwise dmenu does not list new entries in $PATH
i3_refresh_dmenu_cache:
  cmd.run:
    - name: |
        rm {{ pillar['i3']['dmenu_cache_path'] }}
        dmenu_path
    - runas: {{ grains['sugar']['user'] }}
    # Needs to have full PATH in order to find all binaries
    - env:
      - PATH: "{{ salt['environ.get']('PATH') }}:{{ grains['sugar']['extra_path'] }}"
    - require:
      - pkg: i3_pkgs
