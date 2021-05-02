import logging

log = logging.getLogger(__name__)


def __virtual__():
    return True


def directories(name, dirs):
    """
    type dir {
        path    string
        user    string
        group   string
        mode    string
    }

    type dirs []dir
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}
    for d in dirs:
        kwargs = {}
        kwargs["user"] = d.get("user", __grains__["sugar"]["user"])
        kwargs["group"] = d.get("group", __grains__["sugar"]["user"])
        kwargs["mode"] = d.get("mode", "0755")
        kwargs["makedirs"] = True
        res = __states__["file.directory"](d["path"], **kwargs)

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


def dotfiles(name, dfs):
    pass
