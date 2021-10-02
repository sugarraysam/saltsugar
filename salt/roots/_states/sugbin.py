import logging
import os
import shutil
import tempfile
from pathlib import Path

import saltsugar.salt_helpers as helpers

log = logging.getLogger(__name__)


def download_github_releases(name, releases, **kwargs):
    """
    type binary {
        repo        string [required]
        urlfmt      string [required] Can use {tag} and {tag_no_v} templates
        name        string
        dest        string
        tag         string
        user        string
        group       string
    }

    type binaries []binary
    """
    results = {"name": name, "result": False, "changes": {}, "comment": []}

    for release in releases:
        validate_required_fields(release)
        kwargs = get_base_kwargs(release)
        if _is_archive(kwargs["source"]):
            # Backup binary dest because we override kwargs with extract_dir
            dest = Path(kwargs["name"])
            kwargs = get_archive_kwargs(kwargs)
            res = extract_and_copy(kwargs, dest)
        else:
            res = __states__["file.managed"](**kwargs)
        helpers.update_results(results, res)

        # fail fast
        if not res["result"]:
            return helpers.error(results)

    return helpers.success(results)


def validate_required_fields(release):
    required_fields = ["repo", "urlfmt"]
    for field in required_fields:
        if release.get(field) is None:
            log.error(
                "Binary is missing either `repo` or `urlfmt`: %s. Skipping.",
                release,
            )


def get_base_kwargs(release):
    return {
        "name": release.get("dest", _get_dest(release)),
        "source": _get_source(release),
        "user": release.get("user", __grains__["sugar"]["user"]),
        "group": release.get("group", __grains__["sugar"]["user"]),
        "mode": "0755",
        "skip_verify": True,
        "force": True,  # overwrite existing binary
    }


def get_archive_kwargs(kwargs):
    extract_dir = tempfile.TemporaryDirectory()
    kwargs["name"] = extract_dir.name
    # Set to False so we don't fail if archive contains sub-directories
    kwargs["enforce_toplevel"] = False
    kwargs["extract_perms"] = False
    kwargs["enforce_ownership_on"] = extract_dir.name
    if _is_tar_gz(kwargs["source"]):
        kwargs["options"] = " ".join(
            [
                '--exclude="*README.md"',
                '--exclude="*LICENSE"',
                '--exclude="*arm*"',
                '--exclude="*darwin*"',
                '--exclude="*windows*"',
                # flatten archive, e.g.: bin/glab -> glab
                '--transform="s:^.*/::"',
            ]
        )
    if _is_zip(kwargs["source"]):
        # Fails if mode is defined
        kwargs.pop("mode")

    return kwargs


def extract_and_copy(kwargs, dest):
    res = __states__["archive.extracted"](**kwargs)
    try:
        src = Path(kwargs["name"]) / dest.name
        shutil.copy(src, dest)
        os.chmod(dest, mode=0o755)
    except FileNotFoundError as e:
        log.error(
            "Can't find binary in extracted dir: %s. Got %s",
            os.listdir(src.parent),
            e,
        )
    finally:
        return res


def _get_dest(release):
    return f"{__grains__['sugar']['localbin_path']}/{_get_name(release)}"


def _get_name(release):
    default_name = release["repo"].split("/")[1].lower()
    return release.get("name", default_name)


def _get_source(release):
    """
    Resolve the urlfmt by using both {tag} and {tag_no_v}.
    Default to latest github repo tag.
    """
    tag = release.get("tag", helpers.latest_github_repo_tag(release["repo"]))
    tag_no_v = tag[1:] if tag.startswith("v") else tag
    return release["urlfmt"].format(tag=tag, tag_no_v=tag_no_v)


def _is_archive(src):
    return _is_tar_gz(src) or _is_zip(src)


def _is_tar_gz(src):
    return src.endswith(".tar.gz")


def _is_zip(src):
    return src.endswith(".zip")
