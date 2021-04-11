# vi: ft=python
import pwd


def _is_sandbox():
    """Detect if user vagrant exist on machine."""
    try:
        _ = pwd.getpwnam("vagrant")
        return True
    except KeyError:
        return False


def _user(g):
    return "vagrant" if _is_sandbox() else "sugar"


def _user_home(g):
    return f"/home/{_user(g)}"


def main(grains):
    sugar = {}
    sugar["is_sandbox"] = _is_sandbox()

    # User
    sugar["user"] = _user(grains)
    sugar["user_home"] = _user_home(grains)
    sugar["user_groups"] = ["uucp", "wheel", "wireshark"]

    # Base
    sugar["timezone"] = "America/Chicago"
    sugar["hostname"] = "htp"
    sugar["keymap"] = "us"

    # Git
    sugar["git_username"] = "sugarraysam"
    sugar["git_email"] = "samuel.blaisdowdy@protonmail.com"
    return {"sugar": sugar}
