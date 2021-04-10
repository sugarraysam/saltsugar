# Detect if we are running in the sandbox, to adjust values slightly
{% set is_sandbox = grains['host'].startswith('sandbox') %}
{% set user = "vagrant" if is_sandbox else "sugar" %}

defaults:
  user: {{ user }}
  user_groups:
      - uucp
      - wheel
      - wireshark
  user_home: /home/{{ user }}
  #
  # general
  #
  sandbox: {{ is_sandbox }}
  timezone: "America/Chicago"
  hostname: "htp"
  keymap: "us"
  #
  # git
  #
  git_username: sugarraysam
  git_email: samuel.blaisdowdy@protonmail.com
