import logging

log = logging.getLogger(__name__)

# TODO, allow github_binaries that is an archive (boolean)


def dwl_github_binaries(name, binaries, **kwargs):
    """
    type binary {
        repo    string [required]
        urlfmt  string [required]
        dest    string
        tag     string
        user    string
        group   string
        mode    string
    }

    type binaries []binary
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}

    for b in binaries:
        # repo + urlfmt are required
        if b.get("repo") is None or b.get("urlfmt") is None:
            log.error(
                "Binary is missing either `repo` or `urlfmt`: %s. Skipping.",
                b,
            )
            continue

        kwargs.update(
            {
                "name": b.get("dest", _get_dest(b["repo"])),
                "source": _get_source_url(
                    b["repo"], b["urlfmt"], tag=b.get("tag", None)
                ),
                "user": b.get("user", __grains__["sugar"]["user"]),
                "group": b.get("group", __grains__["sugar"]["user"]),
                "mode": b.get("mode", "0755"),
                "makedirs": True,
                "replace": True,  # force replace
                "skip_verify": True,
            }
        )

        res = __states__["file.managed"](**kwargs)
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


def _get_dest(repo):
    name = repo.split("/")[1].lower()
    return f"{__grains__['sugar']['user_home']}/.local/bin/{name}"


def _get_source_url(repo, urlfmt, tag=None):
    """urlfmt MUST have a {version} section"""
    tag = _get_latest_tag(repo) if tag is None else tag
    log.debug("got tag: %s", tag)
    log.debug("got urlfmt: %s", urlfmt)
    return urlfmt.format(version=tag)


def _get_latest_tag(repo):
    # TODO make api call all in python, drop __salt__ (exec)
    cmd = f"curl -fsSL https://api.github.com/repos/{repo}/tags | jq '.[0].name'"
    return ""
