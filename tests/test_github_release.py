import pytest
from saltsugar.github_release import GithubReleaseBinary


@pytest.mark.parametrize(
    "release,releaseClass",
    [
        (
            {
                "repo": "bazelbuild/buildtools",
                "urlfmt": "https://github.com/bazelbuild/buildtools/releases/download/{tag}/buildifier-linux-amd64",
                "name": "buildifier",
            },
            GithubReleaseBinary,
        ),
    ],
)
def test_github_release(tmp_path, release, releaseClass):
    releaseClass(**release, localbin_path=tmp_path).download()

    binary = tmp_path / release["name"]
    assert binary.exists()
    assert oct(binary.stat().st_mode)[-3:] == "755"
