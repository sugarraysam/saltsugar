{% set home = grains['sugar']['user_home'] %}

docker:
  pkgs:
    - docker # Pack, ship and run any application as a lightweight container
    - docker-compose # Fast, isolated development environments using Docker
    - docker-machine # Machine management for a container-centric world
  gh_binaries:
    - {
        repo: "hadolint/hadolint",
        urlfmt: "https://github.com/hadolint/hadolint/releases/download/{tag}/hadolint-Linux-x86_64",
      }
