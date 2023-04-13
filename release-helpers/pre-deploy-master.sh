#!/bin/bash
#TODO: Add slack messages on #

echo "1. Git stash - to prevent work loss"
DATE_STRING=$(date '+%Y-%m-%d_%H-%M-%S')
git stash push -u -m stash-${DATE_STRING}

echo "2. Checking out to rc"
git checkout rc

echo "3. Pulling"
git pull

echo "4. Determine version number"
VERSION_JSON=`yarn version --non-interactive --json | grep "Current"`
VERSION_NUMBER=$(echo $VERSION_JSON | jq '.data' | sed 's/Current version: //g' | tr -d '"')
echo " ... current version number: ${VERSION_NUMBER}"

echo "5. Creating RELEASE tag"
gh release create RELEASE-v${VERSION_NUMBER} -t RELEASE-v${VERSION_NUMBER} -n "" --target "rc"

echo "6. Create PR for release cut tag"
PR_LINK=$(gh pr create --title "PRODUCTION-v${VERSION_NUMBER}" --base master --body "PRODUCTION version ${VERSION_NUMBER}" | grep "pull/")
echo " ... PR Link: ${PR_LINK}"

echo "Finished, please ask your teammates for OKs on the PR above."
