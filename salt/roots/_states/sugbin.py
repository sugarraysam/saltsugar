import logging
import os
import shutil
import tempfile
from pathlib import Path

import saltsugar.github_release as ghr
import saltsugar.salt_utils as utils

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
        gh_release = ghr.constructor(
            **release, localbin_path=__grains__["sugar"]["localbin_path"]
        )
        res = {
            "name": gh_release.__class__,
            "result": True,
            "changes": {},
            "comment": "",
        }
        try:
            gh_release.download()
            res["comment"] = f"Downloaded {gh_release.src} to {gh_release.dst}"

        except ghr.GithubReleaseException as e:
            res["result"] = False
            res["comment"] = (
                f"Failed to download {gh_release.src} to {gh_release.dst} got"
                f" {e}."
            )

        utils.update_results(results, res)

        # fail fast
        if not res["result"]:
            return utils.error(results)

    return utils.success(results)
