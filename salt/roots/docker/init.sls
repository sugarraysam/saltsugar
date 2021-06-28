docker_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['docker']['pkgs'] }}

docker_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['docker']['gh_binaries'] }}

docker_group:
  group.present:
    - name: docker
    - system: True
    - members:
      - {{ grains['sugar']['user'] }}
    - require:
      - pkg: docker_pkgs

docker_svc:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker_pkgs
      - group: docker_group

docker_cleanup:
  cmd.run:
    - name: docker system prune --force --volumes
    - require:
      - pkg: docker_pkgs
      - service: docker_svc
