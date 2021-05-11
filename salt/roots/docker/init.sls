docker_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['docker']['pkgs'] }}

docker_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['docker']['gh_binaries'] }}
