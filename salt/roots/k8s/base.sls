k8s_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['k8s']['pkgs'] }}

k8s_dirs:
  sugfile.directories:
    - dirs: {{ pillar['k8s']['dirs'] }}

k8s_zsh_completions:
  sugcmd.zsh_completions:
    - completions: {{ pillar['k8s']['zsh_completions'] }}
    - require:
      - pkg: k8s_pkgs

k8s_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['k8s']['github_binaries'] }}
