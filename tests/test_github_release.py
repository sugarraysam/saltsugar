import pytest
import saltsugar.github_release as ghr


@pytest.mark.parametrize(
    "release",
    [
        {
            "repo": "bazelbuild/buildtools",
            "urlfmt": "https://github.com/bazelbuild/buildtools/releases/download/{tag}/buildifier-linux-amd64",
            "name": "buildifier",
        },
        {
            "repo": "golangci/golangci-lint",
            "urlfmt": "https://github.com/golangci/golangci-lint/releases/download/{tag}/golangci-lint-{tag_no_v}-linux-amd64.tar.gz",
        },
        {
            "repo": "terraform-linters/tflint",
            "urlfmt": "https://github.com/terraform-linters/tflint/releases/download/{tag}/tflint_linux_amd64.zip",
        },
    ],
)
def test_github_release(tmp_path, release):
    instance = ghr.constructor(**release, localbin_path=tmp_path)
    instance.download()

    binary = tmp_path / instance.name
    assert binary.exists()
    assert oct(binary.stat().st_mode)[-3:] == "755"
