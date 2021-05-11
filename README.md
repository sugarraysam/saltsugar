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
| base      |           |                              |
| blackarch |           |                              |
| cpp       | X         |                              |
| devops    |           |                              |
| docker    | X         |                              |
| firefox   |           |                              |
| go        | X         |                              |
| i3        | X         |                              |
| iptables  |           |                              |
| k8s       | X         |                              |
| nodejs    | X         |                              |
| nvim      |           |                              |
| pacman    |           |                              |
| python    |           |                              |
| ruby      |           |                              |
| rust      |           |                              |
| tmux      |           |                              |
| vbox      |           |                              |
| vscode    |           |                              |
| zsh       |           | add ~/.zshrc.d/pulseaudio.sh |

- `install.sh` script (required pkgs: salt, rsync, zsh, which, etc.)
- install guide for arch linux (custom salt module?)

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
