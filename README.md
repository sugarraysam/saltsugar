# Saltsugar

Salt configuration to manage an ArchLinux machine. Also includes bootstraping scripts, following many instructions from the [Arch Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

# Bootstrap

TODO

# Salt

TODO

# Roadmap

- fix grub, efi GRUB is registered but not booting
  - review vfat partition
  - review EFI grub cfg
- does grub need a pacman hook after upgrade? kernel upgrade?
- pre-commit config
- hadolint error

```
  [ERROR ] Binary is missing either `repo` or `urlfmt`: OrderedDict([('name', 'hadolint/hadolint'), ('urlfmt', 'https://github.com/hadolint/hadolint/releases/download/{tag}/hadolint-Linux-x86_64')]). Skipping.
```

- go_gh_binary error

```
          ID: go_gh_binaries
    Function: sugbin.dwl_gh_binaries
      Result: False
     Comment: https://github.com/golangci/golangci-lint/releases/download/v1.40.1/golangci-lint-1.40.1-linux-amd64.tar.gz extracted to /home/suga
r/.local/bin/, due to absence of one or more files/dirs. Output was trimmed to False number of lines
              https://github.com/fullstorydev/grpcurl/releases/download/v1.8.1/grpcurl_1.8.1_linux_x86_64.tar.gz extracted to /home/sugar/.local/
bin/, due to absence of one or more files/dirs. Output was trimmed to False number of lines
              Error: HTTP 404: Not Found reading https://github.com/goreleaser/goreleaser/releases/download/v0.168.1/goreleaser_Linux_x86_64.tar.
gz
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

# Resources

- [Write custom state modules](https://docs.saltproject.io/en/latest/ref/states/writing.html)
- [Cross calling execution modules](https://docs.saltproject.io/en/latest/ref/modules/index.html#cross-calling-execution-modules)
- [Archlinux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
