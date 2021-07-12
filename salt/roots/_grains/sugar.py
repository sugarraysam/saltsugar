# vi: ft=python
import os
import pwd
import re
import subprocess


def _is_sandbox():
    """Detect if user vagrant exist on machine."""
    try:
        _ = pwd.getpwnam("vagrant")
        return True
    except KeyError:
        return False


# Keep up-to-date with `salt/roots/zsh/dotfiles/zshrc`
def _extra_path(user, home):
    """Return augmented path to use as env in custom commands."""
    ruby_path = subprocess.run(
        ["sudo", "-u", user, "ruby", "-e", "puts Gem.user_dir"],
        capture_output=True,
        text=True,
    ).stdout

    return ":".join(
        [
            # pyenv
            os.path.join(home, ".pyenv/shims"),
            # python + custom
            os.path.join(home, ".local/bin"),
            # go
            os.path.join(home, ".go/bin"),
            # nodejs
            os.path.join(home, ".node_modules/bin"),
            # ruby
            f"{ruby_path}/bin",
            # rust
            os.path.join(home, ".cargo/bin"),
            # k8s krew
            os.path.join(home, ".krew/bin"),
        ]
    )


def _vtx_enabled(g):
    """Detect if system supports VTx using /proc/cpuinfo."""
    regex = re.compile("svm|vtx")
    with open("/proc/cpuinfo") as f:
        for line in f:
            if regex.search(line) is not None:
                return True
    return False


def main(grains):
    sugar = {}
    sugar["is_sandbox"] = _is_sandbox()

    # User
    sugar["user"] = "vagrant" if sugar["is_sandbox"] else "sugar"
    sugar["home"] = os.path.join("/home", sugar["user"])
    sugar["extra_path"] = _extra_path(sugar["user"], sugar["home"])
    sugar["zshrcd_path"] = os.path.join(sugar["home"], ".zshrc.d")
    sugar["localbin_path"] = os.path.join(sugar["home"], ".local/bin")

    # General
    sugar["timezone"] = "America/Chicago"
    sugar["hostname"] = "htp"
    sugar["keymap"] = "us"
    sugar["vtx_enabled"] = _vtx_enabled(grains)

    # Git
    sugar["git_username"] = "sugarraysam"
    sugar["git_email"] = "samuel.blaisdowdy@protonmail.com"
    return {"sugar": sugar}
