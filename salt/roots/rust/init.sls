rust_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['rust']['pkgs'] }}

rust_dirs:
  sugfile.directories:
    - dirs: {{ pillar['rust']['dirs'] }}
    - require:
      - pkg: rust_pkgs

{% for t in pillar['rust']['rustup_toolchains'] %}
update_rustup_toolchain_{{ t }}:
  cmd.run:
    - name: rustup toolchain install {{ t }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: rust_pkgs
{% endfor %}

set_rustup_default_toolchain:
  cmd.run:
    - name: rustup default {{ pillar['rust']['rustup_default_toolchain'] }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: update_rustup_toolchain_{{ pillar['rust']['rustup_default_toolchain'] }}

{% for c in pillar['rust']['rustup_components'] %}
install_rustup_component_{{ c }}:
  cmd.run:
    - name: rustup component add {{ c }} --toolchain {{ pillar['rust']['rustup_default_toolchain'] }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: set_rustup_default_toolchain
{% endfor %}
