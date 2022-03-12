import json
from urllib.request import urlopen


def update_results(results, res):
    """Update results in-place."""
    results["changes"].update(res["changes"])
    results["comment"].append(res["comment"])


def error(results):
    results["result"] = False
    return _join_comment_messages(results)


def success(results):
    results["result"] = True
    return _join_comment_messages(results)


def _join_comment_messages(results):
    results["comment"] = "\n".join(results["comment"])
    return results


def latest_github_repo_tag(repo_name):
    with urlopen(
        f"https://api.github.com/repos/{repo_name}/releases/latest"
    ) as response:
        body = response.read().decode("utf-8")
        body_json = json.loads(body)
        return body_json["tag_name"]
