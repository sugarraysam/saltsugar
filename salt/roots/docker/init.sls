docker_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['docker']['pkgs'] }}

docker_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['docker']['gh_binaries'] }}

add_user_to_docker_group:
  user.present:
    - name: {{ grains['sugar']['user'] }}
    - groups:
      - docker
    - require:
      - pkg: docker_pkgs
