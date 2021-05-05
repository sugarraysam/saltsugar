import logging

log = logging.getLogger(__name__)


def zsh_completions(name, completions, **kwargs):
    """
    type completions []string
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}
    for c in completions:
        res = __states__["cmd.run"](c, **kwargs)
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
