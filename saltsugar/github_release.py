import os
from abc import ABC, abstractmethod

import requests

from saltsugar.logger import new_text_logger
from saltsugar.salt_utils import latest_github_repo_tag

# TODO:
# 1. plain binary
# 2. .zip
# 3. .tar.gz

# __metaclass__
# abstract class?


class GithubRelease(ABC):
    def __init__(
        self,
        repo,
        urlfmt,
        localbin_path="/home/sugar/.local/bin",
        tag=None,
        name=None,
    ):
        self.repo = repo
        self.urlfmt = urlfmt
        self.localbin_path = localbin_path
        self.src = self._get_src(tag)
        self.dst = self._get_dst(name)
        self.log = new_text_logger("github_release")

    def _get_src(self, tag):
        """
        Resolve the urlfmt by using both {tag} and {tag_no_v}.
        Default to latest github repo tag.
        """
        tag = latest_github_repo_tag(self.repo) if tag is None else tag
        tag_no_v = tag[1:] if tag.startswith("v") else tag
        return self.urlfmt.format(tag=tag, tag_no_v=tag_no_v)

    def _get_dst(self, name):
        name = self.repo.split("/")[1].lower() if name is None else name
        return f"{self.localbin_path}/{name}"

    @abstractmethod
    def _download_and_copy(self):
        pass

    def download(self):
        self.log.info(f"Downloading {self.src} to {self.dst}.")
        self._download_and_copy()

        self.log.info(f"Making {self.dst} executable.")
        os.chmod(self.dst, mode=0o755)

    def __str__(self):
        return (
            f"GithubRelease(repo={self.repo}, urlfmt={self.urlfmt},"
            f" localbin_path={self.localbin_path}, src={self.src},"
            f" dst={self.dst})"
        )


class GithubReleaseBinary(GithubRelease):
    def _download_and_copy(self):
        try:
            response = requests.get(self.src)
            response.raise_for_status()
            with open(self.dst, "wb") as file:
                file.write(response.content)

        except requests.exceptions.RequestException as e:
            err_msg = f"Failed to download {self.src}: {e}."
            self.log.error(err_msg)
            raise GithubReleaseException(err_msg)
