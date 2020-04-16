#!/bin/bash

set -e

cat << EOS | sed -i '1r /dev/stdin' CHANGELOG.md

## [${INPUT_RELEASE_VERSION##v}] - $(date "+%Y-%m-%d")

${INPUT_RELEASE_SUMMARY}

$(echo "${INPUT_RELEASE_BODY}" | sed 's/^#/\#\#/')
EOS
cat package.json | jq -Mr '. | .version = "'"${INPUT_RELEASE_VERSION##v}"'"' > /tmp/package.json
mv /tmp/package.json package.json

npm-cli-adduser -u $INPUT_NPM_USER -p $INPUT_NPM_PASS -e github-actions@example.com -r $INPUT_NPM_URL

npm publish --registry $INPUT_NPM_URL

git config --global user.email "github-actions@example.com"
git config --global user.name "GitHub Actions"
git checkout -b "temporary-$(date '+%Y%m%d%H%M%S')"
git add .
git commit -m ":up: Bump up version: ${INPUT_RELEASE_VERSION}" && git push "https://${INPUT_GITHUB_ACTOR}}:${INPUT_GITHUB_TOKEN}@github.com/${INPUT_GITHUB_REPOSITORY}.git" HEAD:${INPUT_RELEASE_BRANCH} || true
git tag -d ${INPUT_RELEASE_VERSION}
git tag ${INPUT_RELEASE_VERSION}
git push --tags --force
