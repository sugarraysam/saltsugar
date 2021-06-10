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

- refactor custom states, Result class with easier upgrade + error detection + logging ?
- pavucontrol show up in dmenu how to?
- all files in ~/.zshrc.d/ should be in their respective states
- look into zplug for zsh plugins (https://github.com/zplug/zplug)
- does grub need a pacman hook after upgrade? kernel upgrade?
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
