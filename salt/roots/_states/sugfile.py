import logging

log = logging.getLogger(__name__)


def directories(name, dirs, **kwargs):
    """
    type dir {
        path    string [required]
        user    string
        group   string
        mode    string
    }

    type dirs []dir
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}
    for d in dirs:
        # path is required
        if d.get("path") is None:
            log.error("Directory %s does not have a path argument", d)
            continue
        kwargs.update(
            {
                "name": d["path"],
                "user": d.get("user", __grains__["sugar"]["user"]),
                "group": d.get("group", __grains__["sugar"]["user"]),
                "mode": d.get("mode", "0755"),
                "makedirs": True,
            }
        )
        res = __states__["file.directory"](**kwargs)
        results["changes"].update(res["changes"])
        results["comment"].append(res["comment"])

        # Error
        if not res["result"]:
            results["comment"] = "\n".join(results["comment"])
            return results

        # Success
        results["result"] = True
        results["comment"] = "\n".join(results["comment"])
        return results


def symlink_dotfiles(name, dotfiles, **kwargs):
    """
    type dotfile {
        dest    string [required]
        src     string [required]
        user    string
        group   string
        mode    string
    }

    type dotfiles []dotfile
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}
    for d in dotfiles:
        # dest + src are required
        if d.get("dest") is None or d.get("src") is None:
            log.error("Dotfiles %s is missing either 'dest' or 'src'", d)
            continue

        kwargs.update(
            {
                "name": d["dest"],
                "target": d["src"],
                "user": d.get("user", __grains__["sugar"]["user"]),
                "group": d.get("group", __grains__["sugar"]["user"]),
                "mode": d.get("mode", "0644"),
                "force": True,
                "makedirs": True,
            }
        )

        res = __states__["file.symlink"](**kwargs)
        results["changes"].update(res["changes"])
        results["comment"].append(res["comment"])

        # Error
        if not res["result"]:
            results["comment"] = "\n".join(results["comment"])
            return results

        # Success
        results["result"] = True
        results["comment"] = "\n".join(results["comment"])
        return results


def remove_files(name, files, **kwargs):
    """
    type files []string
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}
    for f in files:
        res = __states__["file.absent"](f, **kwargs)
        results["changes"].update(res["changes"])
        results["comment"].append(res["comment"])

        # Error
        if not res["result"]:
            results["comment"] = "\n".join(results["comment"])
            return results

        # Success
        results["result"] = True
        results["comment"] = "\n".join(results["comment"])
        return results
