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

| Scenario  | Migrated? | Notes                            |
| --------- | --------- | -------------------------------- |
| X         |           |                                  |
| backup    |           |                                  |
| base      |           |                                  |
| blackarch |           |                                  |
| cpp       |           |                                  |
| devops    |           |                                  |
| docker    |           |                                  |
| firefox   |           |                                  |
| go        |           |                                  |
| i3        |           |                                  |
| iptables  |           |                                  |
| k8s       |           | Add $HOME/.kube/kind-config.yaml |
| nodejs    |           |                                  |
| nvim      |           |                                  |
| pacman    |           |                                  |
| python    |           |                                  |
| ruby      |           |                                  |
| rust      |           |                                  |
| tmux      |           |                                  |
| vbox      |           |                                  |
| vscode    |           |                                  |
| zsh       |           | add ~/.zshrc.d/pulseaudio.sh     |

- `install.sh` script (required pkgs: salt, rsync, zsh, which, etc.)
- install guide for arch linux (custom salt module?)

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
