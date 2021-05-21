{% set home = grains['sugar']['user_home'] %}

iptables:
  pkgs:
    - iptables # Linux kernel packet control tool (using legacy interface)
  dotfiles:
    - {
        src: /srv/salt/iptables/dotfiles/iptables.rules,
        dest: /etc/iptables/iptables.rules,
      }
    - {
        src: /srv/salt/iptables/dotfiles/ip6tables.rules,
        dest: /etc/iptables/ip6tables.rules,
      }
