{% set home = grains['sugar']['home'] %}

docker:
  pkgs:
    - docker # Pack, ship and run any application as a lightweight container
    - docker-compose # Fast, isolated development environments using Docker
    - docker-machine # Machine management for a container-centric world
  dotfiles:
    - {
        src: /srv/salt/docker/dotfiles/docker.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/docker.sh,
      }
  gh_binaries:
    - {
        repo: "hadolint/hadolint",
        urlfmt: "https://github.com/hadolint/hadolint/releases/download/{tag}/hadolint-Linux-x86_64",
      }
