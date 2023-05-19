#!/bin/bash
VERSION=$(shell sed -n "s/^.*version='\([^']*\)'.*$$/\1/p" setup.py)
TAG="v$VERSION"
TITLE="$TAG"
DESCRIPTION="Install with `pip install gpt-code-ui` or download bundle and run `pip install -e .`."

# If $GH_API_TOKEN print error
if [ -z "$GH_API_TOKEN" ]; then
    echo "Error: Please set the GH_API_TOKEN environment variable."
    exit 1
fi

API_JSON=$(printf '{"tag_name": "%s", "target_commitish": "master", "name": "%s", "body": "%s", "draft": false, "prerelease": false}' "$TAG" "$TITLE" "$DESCRIPTION")

curl --data "$API_JSON" https://api.github.com/repos/ricklamers/gpt-code-ui/releases?access_token=$GH_API_TOKEN