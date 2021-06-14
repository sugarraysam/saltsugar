go_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['go']['pkgs'] }}

go_dirs:
  sugfile.directories:
    - dirs: {{ pillar['go']['dirs'] }}

go_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['go']['gh_binaries'] }}

go_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['go']['zsh_completions'] }}
    - require:
      - pkg: go_pkgs
      - sugbin: go_gh_binaries
      - cmd: go_cmd_install_ocm

# Run go cmds
{% for c in pillar['go']['cmds'] %}
go_cmd_{{ c.id }}:
  cmd.run:
    - name: "{{ c.cmd }}"
    - runas: {{ grains['sugar']['user'] }}
    - env:
      - GO111MODULE: auto
      - GOPATH: {{ pillar['go']['gopath'] }}
      - GOBIN: {{ pillar['go']['gobin'] }}
    - require:
      - pkg: go_pkgs
      - sugfile: go_dirs
{% endfor %}
