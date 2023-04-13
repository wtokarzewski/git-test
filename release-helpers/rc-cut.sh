#!/bin/bash

echo "1. Git stash - to prevent work loss"
DATE_STRING=$(date '+%Y-%m-%d_%H-%M-%S')
git stash push -u -m stash-${DATE_STRING}

echo "2. Checking out to develop"
git checkout develop

echo "3. Pulling"
git pull

echo "4. Determine version number"
VERSION_JSON=`yarn version --non-interactive --json | grep "Current"`
VERSION_NUMBER=$(echo $VERSION_JSON | jq '.data' | sed 's/Current version: //g' | tr -d '"')
echo " ... current version number: ${VERSION_NUMBER}"

echo "5. Create release branch"
git checkout -b release/RELEASE-v${VERSION_NUMBER} || git checkout release/RELEASE-v${VERSION_NUMBER}

echo "6. Push release branch"
git push --set-upstream origin release/RELEASE-v${VERSION_NUMBER}

sleep 5s

echo "7. Create PR for release branch"
PR_LINK=$(gh pr create --title "RELEASE-v${VERSION_NUMBER}" --base rc --body "RELEASE version ${VERSION_NUMBER}" | grep "pull/")

echo "8. Check out develop"
git checkout develop

echo " ... PR Link: ${PR_LINK}"

echo "Finished."
