cpp_pkgs:
  pkg.installed:
    - pkgs: {{ pillar['cpp']['pkgs'] }}

cpp_gh_binaries:
  sugbin.dwl_gh_binaries:
    - binaries: {{ pillar['cpp']['gh_binaries'] }}
