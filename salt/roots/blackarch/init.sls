# Run only once if blackarch is not already installed
blackarch_install:
  cmd.run:
    - creates: /etc/pacman.d/blackarch-mirrorlist
    - name: |
        curl -fsSL -o /tmp/strap.sh {{ pillar['blackarch']['install_script_url'] }}
        echo "{{ pillar['blackarch']['install_script_sha'] }} /tmp/strap.sh" | sha1sum -c
        chmod +x /tmp/strap.sh
        /tmp/strap.sh
        rm /tmp/strap.sh

blackarch_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['blackarch']['pkgs'] }}
    - require:
      - cmd: blackarch_install

blackarch_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['blackarch']['dotfiles'] }}

{% for r in pillar['blackarch']['git_repos'] %}
blackarch_git_repos_{{ r.name }}:
  git.latest:
    - name: {{ r.url }}
    - target: {{ r.dest }}
    - user: {{ grains['sugar']['user'] }}
    - rev: master
    - depth: 1
    - force_checkout: True # discard unwritten changes
    - force_clone: True # overwrite existing dir
{% endfor %}
