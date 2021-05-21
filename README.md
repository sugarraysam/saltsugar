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

| Scenario  | Migrated? | Notes                        |
| --------- | --------- | ---------------------------- |
| X         | X         |                              |
| backup    |           |                              |
| common    | X         |                              |
| blackarch | X         |                              |
| cpp       | X         |                              |
| devops    |           |                              |
| docker    | X         |                              |
| firefox   |           |                              |
| go        | X         |                              |
| i3        | X         |                              |
| iptables  | X         |                              |
| k8s       | X         |                              |
| nodejs    | X         |                              |
| nvim      | X         |                              |
| pacman    | X         | Merged in "common"           |
| python    |           |                              |
| ruby      |           |                              |
| rust      |           |                              |
| tmux      |           |                              |
| vbox      |           |                              |
| vscode    |           |                              |
| zsh       |           | add ~/.zshrc.d/pulseaudio.sh |

- `install.sh` script (required pkgs: salt, rsync, zsh, which, etc.)
- install guide for arch linux (custom salt module?)
  -- inspect bootstrap + chroot stages ++ turn them in salt/bash scripts (easy-to-use)
  -- setup user + sudo (/etc/sudoers.d/<user>)

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
