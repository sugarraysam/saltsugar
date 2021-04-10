# vi: ft=python


def _is_sandbox(g):
    return g["host"].startswith("sandbox")


def _user(g):
    return "vagrant" if _is_sandbox(g) else "sugar"


def _user_home(g):
    return f"/home/{_user(g)}"


def main(grains):
    defaults = {}
    defaults["is_sandbox"] = _is_sandbox(grains)
    defaults["user"] = _user(grains)
    defaults["user_home"] = _user_home(grains)
    defaults["user_groups"] = ["uucp", "wheel", "wireshark"]
    defaults["timezone"] = "America/Chicago"
    defaults["hostname"] = "htp"
    defaults["keymap"] = "us"
    defaults["git_username"] = "sugarraysam"
    defaults["git_email"] = "samuel.blaisdowdy@protonmail.com"
    return {"defaults": defaults}
