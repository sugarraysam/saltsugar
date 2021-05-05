import json
import logging
import os
from urllib.request import urlopen

log = logging.getLogger(__name__)


def dwl_gh_binaries(name, binaries, **kwargs):
    """
    type binary {
        repo        string [required]
        urlfmt      string [required]
        dest        string
        tag         string
        user        string
        group       string
        mode        string
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

        kwargs = _get_kwargs_update_dict(b)
        create_dir(**kwargs)
        if _is_archive(b):
            res = __states__["archive.extracted"](**kwargs)
        else:
            res = __states__["file.managed"](**kwargs)
        set_user_group_perms(**kwargs)
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


def create_dir(name, user, group, **kwargs):
    # if ends with '/' its a no-op
    d = os.path.dirname(name)
    _ = __states__["file.directory"](
        name=d, user=user, group=group, mode="0755", makedirs=True
    )


def set_user_group_perms(name, user, group, **kwargs):
    d = os.path.dirname(name)
    _ = __states__["file.directory"](
        name=name,
        user=user,
        group=group,
        mode="0755",
        recurse=["user", "group", "mode"],
    )


def _get_kwargs_update_dict(b):
    res = {
        "name": b.get("dest", _get_dest(b)),
        "source": _get_source_url(b),
        "user": b.get("user", __grains__["sugar"]["user"]),
        "group": b.get("group", __grains__["sugar"]["user"]),
        "skip_verify": True,
    }
    if _is_archive(b):
        res["options"] = _get_archive_opts(b)
    else:
        res["replace"] = True  # force replace
    return res


def _get_name(b):
    return b["repo"].split("/")[1].lower()


def _get_dest(b):
    base = f"{__grains__['sugar']['user_home']}/.local/bin/"
    if _is_archive(b):
        return base
    else:
        return base + _get_name(b)


def _get_source_url(b):
    """urlfmt MUST have a {tag} section"""
    tag = _get_latest_tag(b)
    return b["urlfmt"].format(tag=tag)


def _get_latest_tag(b):
    if b.get("tag") is not None:
        return b.get("tag")

    with urlopen(f"https://api.github.com/repos/{b['repo']}/tags") as response:
        body = response.read().decode("utf-8")
        body_json = json.loads(body)
        return body_json[0]["name"]


def _is_archive(b):
    return b["urlfmt"].endswith(".tar.gz")


def _get_archive_opts(b):
    return " ".join(
        [
            '--exclude="*README.md"',
            '--exclude="*LICENSE"',
            '--exclude="*arm*"',
            '--exclude="*darwin*"',
            '--exclude="*windows*"',
            f'--transform="s/^.*/{_get_name(b)}/"',
        ]
    )
