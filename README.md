# Saltsugar

Salt configuration to manage an ArchLinux machine. Also includes bootstraping scripts, following many instructions from the [Arch Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

# Bootstrap

To bootstrap a new system, follow these instructions:

```bash
# Connect to your wifi
$ iwctl
[iwd] device list
[iwd] station <device> scan
[iwd] station <device> get-networks
[iwd] station <device> connect <SSID>
[iwd] exit

# Install prerequisites
$ pacman -Syy
$ pacman -S make git vim

# Clone repo
$ cd /root
$ git clone https://github.com/sugarraysam/saltsugar.git

# Edit Makefile and bootstrap
$ vim Makefile
$ make bootstrap
```

# Salt

TODO

# Roadmap

### btrfs

- review btrfs installation and subvolumes, test in pacstrap
- run `btrfs scrub start /` weekly
- run `btrfs balance start -musage=50 -dusage=50 /` ??

### other

- add yay OO class? use subprocess to run yay commands as users /w --yes everywhere ++ add `yay_pkgs` integration
  - search is it possible to script yay installs? (asks sudo) use root?
  - https://wiki.archlinux.org/title/Node.js_#Alternate_installations
- add nvm install + upgrade script
- add tfenv + add user to `tfenv` group
- import logging from `sretoolbox` + use
- get rid of `~/perso` and put everything in `~/opt/perso` so its backed in git
- add logging
- docker configure credential helper

```bash
WARNING! Your password will be stored unencrypted in /home/sugar/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
```

- all files in ~/.zshrc.d/ should be in their respective states
- review X start order ++ refactor scripts
  - .zprofile
  - .xinitrc
  - .xserverrc
- look into zplug for zsh plugins (https://github.com/zplug/zplug)
- make sure kernel (pacman -Syu) runs at very end of highstate ++ only prompt for reboot if /lib/modules/$(uname -r) dont exist (meaning kernel was upgraded)

| Scenario  | Migrated? | Notes                                                                |
| --------- | --------- | -------------------------------------------------------------------- |
| X         | X         |                                                                      |
| backup    |           |                                                                      |
| common    | X         |                                                                      |
| blackarch | X         |                                                                      |
| cpp       | X         |                                                                      |
| devops    | X         |                                                                      |
| docker    | X         |                                                                      |
| firefox   |           | TODO                                                                 |
| go        | X         |                                                                      |
| i3        | X         |                                                                      |
| iptables  | X         |                                                                      |
| k8s       | X         |                                                                      |
| nodejs    | X         |                                                                      |
| nvim      |           | add fzf plugins, review config (https://github.com/junegunn/fzf.vim) |
| pacman    | X         | Merged in "common"                                                   |
| python    | X         |                                                                      |
| ruby      | X         |                                                                      |
| rust      | X         |                                                                      |
| tmux      | X         |                                                                      |
| vbox      | X         |                                                                      |
| vscode    | X         | merged in devops                                                     |
| zsh       |           | add ~/.zshrc.d/pulseaudio.sh, write fzf plugins/scripts              |

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
- [Archlinux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
