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

**Bootstrap**

| Name           | Migrated | Notes |
| -------------- | -------- | ----- |
| partition.yml  | X        |       |
| cryptsetup.yml |          |       |
| mount.yml      |          |       |
| pacstrap.yml   |          |       |
| initramfs.yml  |          |       |
| bootloader.yml |          |       |

**Chroot**

| Name          | Migrated | Notes |
| ------------- | -------- | ----- |
| clock.yml     |          |       |
| languages.yml |          |       |
| user.yml      |          |       |
| pacman.yml    |          |       |
| systemd.yml   |          |       |
| swap.yml      |          |       |

- `install.sh` script (required pkgs: salt, rsync, zsh, which, etc.)
- install guide for arch linux (custom salt module?)
  -- inspect bootstrap + chroot stages ++ turn them in salt/bash scripts (easy-to-use)
  -- setup user + sudo (/etc/sudoers.d/<user>)

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
- [Archlinux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
