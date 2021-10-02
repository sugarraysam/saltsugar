ruby_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['ruby']['pkgs'] }}

install_gems:
  cmd.run:
    - name: gem install --user-install {{ " ".join(pillar['ruby']['gems']) }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: ruby_pkgs

clean_old_gems:
  cmd.run:
    - name: gem cleanup --user-install
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: install_gems
