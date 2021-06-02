# Saltsugar

Salt configuration to manage an ArchLinux machine.

# Testing

You can test this project using the provided `Vagrantfile`:

```bash
$ make up
```

# TODO

- pre-commit config
- merge all scenarios from archsugar
- hadolint error

```
  [ERROR ] Binary is missing either `repo` or `urlfmt`: OrderedDict([('name', 'hadolint/hadolint'), ('urlfmt', 'https://github.com/hadolint/hadolint/releases/download/{tag}/hadolint-Linux-x86_64')]). Skipping.
```

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
| firefox   |           |                                                                      |
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

# Bootstrap

**Bootstrap - Success**

| Name           | Migrated | Notes |
| -------------- | -------- | ----- |
| partition.yml  | X        |       |
| cryptsetup.yml | X        |       |
| mount.yml      | X        |       |
| pacstrap.yml   | X        |       |

**Chroot - TODO finish writing this**

| Name           | Migrated | Notes                                        |
| -------------- | -------- | -------------------------------------------- |
| initramfs.yml  | X        | moved from bootstrap                         |
| clock.yml      |          |                                              |
| languages.yml  |          |                                              |
| user.yml       |          | clone saltsugar to /home/sugar/opt/saltsugar |
| pacman.yml     |          | keyring + mirrorlist already copied          |
| systemd.yml    |          |                                              |
| swap.yml       |          |                                              |
| bootloader.yml |          |                                              |

- `install.sh` script (required pkgs: salt, rsync, zsh, which, etc.)
- install guide for arch linux (custom salt module?)
  -- inspect bootstrap + chroot stages ++ turn them in salt/bash scripts (easy-to-use)
  -- setup user + sudo (/etc/sudoers.d/<user>)

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
- [Archlinux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
