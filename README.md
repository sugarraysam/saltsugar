# Saltsugar

Salt configuration to manage an ArchLinux machine. Also includes bootstraping scripts, following many instructions from the [Arch Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

# Bootstrap

TODO

# Salt

TODO

# Roadmap

- does grub need a pacman hook after upgrade? kernel upgrade?
- pre-commit config
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

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
- [Archlinux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
