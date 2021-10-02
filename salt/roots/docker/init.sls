docker_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['docker']['pkgs'] }}

docker_symlink_dotfiles:
  sugfile.symlink_dotfiles:
    - dotfiles: {{ pillar['docker']['dotfiles'] }}

docker_github_releases:
  sugbin.download_github_releases:
    - releases: {{ pillar['docker']['github_releases'] }}

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
