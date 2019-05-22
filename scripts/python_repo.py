import os
import sys
import json
import subprocess


def main():
    dirname = os.path.abspath(os.path.dirname(__file__))
    config_filename = os.path.join(dirname, "repo.json")
    with open(config_filename) as f:
        config = json.load(f)

    for repo in config:
        if repo["type"] == "pypi":
            subprocess.check_call(["pip", "install", repo["name"]])
        else:
            assert repo["type"] == "git"
            url = repo["url"]
            package = repo["name"]
            if package in os.environ:
                # use that sha instead
                branch = os.environ[package]
            elif package.replace("-", "_") in os.environ:
                branch = os.environ[package.replace("-", "_")]
            else:
                branch = repo["branch"]
            base_url = f"git+{url}@{branch}#egg={package}"
            if "subdir" in repo:
                subdir = repo["subdir"]
                base_url += f"&subdirectory={subdir}"
            subprocess.check_call(["pip", "install", "-e", base_url])

if __name__ == "__main__":
    main()
