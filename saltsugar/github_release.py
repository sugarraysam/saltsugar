import io
import os
import tarfile
import zipfile
from abc import ABC, abstractmethod

import requests

from saltsugar.logger import new_text_logger
from saltsugar.salt_utils import latest_github_repo_tag


class GithubReleaseException(Exception):
    pass


def constructor(repo, urlfmt, **kwargs):
    if urlfmt.endswith(".tar.gz"):
        return GithubReleaseTarGz(repo, urlfmt, **kwargs)

    elif urlfmt.endswith(".zip"):
        return GithubReleaseZip(repo, urlfmt, **kwargs)

    return GithubReleaseBinary(repo, urlfmt, **kwargs)


class GithubReleaseABC(ABC):
    def __init__(
        self,
        repo,
        urlfmt,
        localbin_path="/home/sugar/.local/bin",
        member_name=None,
        tag=None,
        name=None,
    ):
        self.repo = repo
        self.urlfmt = urlfmt
        self.localbin_path = localbin_path
        self.name = self._get_name(name)
        self.member_name = member_name if member_name is not None else self.name
        self.tag = self._get_tag(tag)
        self.src = self._get_src()
        self.dst = f"{self.localbin_path}/{self.name}"
        self.log = new_text_logger("github_release")

    def _get_name(self, name):
        """
        Binary name defaults to last part of repo name.
        """
        return self.repo.split("/")[1].lower() if name is None else name

    def _get_tag(self, tag):
        """
        Default to latest github repo tag.
        """
        return latest_github_repo_tag(self.repo) if tag is None else tag

    def _get_src(self):
        """
        Resolve the urlfmt by using both {tag} and {tag_no_v}.
        """
        tag_no_v = self.tag[1:] if self.tag.startswith("v") else self.tag
        return self.urlfmt.format(tag=self.tag, tag_no_v=tag_no_v)

    @abstractmethod
    def _extract(self, content):
        pass

    def download(self):
        try:
            self.log.debug(f"Downloading {self.src}.")
            response = requests.get(self.src)
            response.raise_for_status()

            content = response.content
            response.close()

            self._write_binary(self._extract(content))

        except requests.exceptions.RequestException as e:
            err_msg = f"Failed to download {self.src}: {e}."
            self.log.error(err_msg)
            raise GithubReleaseException(err_msg)

    def _write_binary(self, content):
        self.log.debug(f"Writing binary to {self.dst}.")
        with open(self.dst, "wb") as f:
            f.write(content)
        os.chmod(self.dst, mode=0o755)

    def __str__(self):
        return (
            f"GithubRelease(repo={self.repo}, urlfmt={self.urlfmt},"
            f" localbin_path={self.localbin_path}, src={self.src},"
            f" dst={self.dst})"
        )


class GithubReleaseBinary(GithubReleaseABC):
    """
    Nothing to do.
    """

    def _extract(self, content):
        return content


class GithubReleaseTarGz(GithubReleaseABC):
    def _extract(self, tar_bytes):
        with tarfile.open(fileobj=io.BytesIO(tar_bytes)) as tf:
            for name in tf.getnames():
                if name.endswith(self.member_name):
                    return tf.extractfile(name).read()

            # not found
            err_msg = (
                f"Archive does not contain {self.member_name}. Members are"
                f" {tf.getnames()}."
            )
            self.log.error(err_msg)
            raise GithubReleaseException(err_msg)


class GithubReleaseZip(GithubReleaseABC):
    def _extract(self, zip_bytes):
        with zipfile.ZipFile(io.BytesIO(zip_bytes)) as archive:
            for name in archive.namelist():
                if name.endswith(self.member_name):
                    with archive.open(name, mode="r") as zf:
                        return zf.read()

            # not found
            err_msg = (
                f"Archive does not contain {self.member_name}. Members are"
                f" {archive.namelist()}."
            )
            self.log.error(err_msg)
            raise GithubReleaseException(err_msg)
