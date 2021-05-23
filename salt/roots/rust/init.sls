rust_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['rust']['pkgs'] }}

rust_dirs:
  sugfile.directories:
    - dirs: {{ pillar['rust']['dirs'] }}
    - require:
      - pkg: rust_pkgs

{% for t in ["stable", "nightly"] %}
update_rustup_toolchain_{{ t }}:
  cmd.run:
    - name: rustup toolchain install {{ t }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: rust_pkgs
{% endfor %}

{% for c in pillar['rust']['rustup_components'] %}
install_rustup_component_{{ c.name }}:
  cmd.run:
    - name: rustup component add {{ c.name }} --toolchain {{ c.toolchain }}
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - cmd: update_rustup_toolchain_{{ c.toolchain }}
{% endfor %}
