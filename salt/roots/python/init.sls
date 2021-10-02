python_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['python']['pkgs'] }}

# Recursively delete pip + pipenv cache
{% for d in ["pip", "pipenv"] %}
clear_{{ d }}_cache:
  file.absent:
    - name: {{ grains['sugar']['home'] }}/.cache/{{ d }}
{% endfor %}

ensure_pip:
  cmd.run:
    - name: /usr/bin/python -m ensurepip -U --user
    - runas: {{ grains['sugar']['user'] }}
    - require:
      - pkg: python_pkgs

install_pip_pkgs:
  cmd.run:
    - name: {{ grains['sugar']['localbin_path'] }}/pip3 install --user -U {{ " ".join(pillar['python']['pip_pkgs']) }}
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - PATH: "{{ salt['environ.get']('PATH') }}:{{ grains['sugar']['extra_path'] }}"
    - require:
      - pkg: python_pkgs
      - cmd: ensure_pip
