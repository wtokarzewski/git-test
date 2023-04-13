#!/bin/bash
#TODO: Add slack messages on #

echo "1. Git stash - to prevent work loss"
DATE_STRING=$(date '+%Y-%m-%d_%H-%M-%S')
git stash push -u -m stash-${DATE_STRING}

echo "2. Checking out to master"
git checkout master

echo "3. Pulling"
git pull

echo "4. Determine version number"
VERSION_JSON=`yarn version --non-interactive --json | grep "Current"`
VERSION_NUMBER=$(echo $VERSION_JSON | jq '.data' | sed 's/Current version: //g' | tr -d '"')
echo " ... current version number: ${VERSION_NUMBER}"

echo "5. Create github PRODUCTION release"
gh release create PRODUCTION-v${VERSION_NUMBER} -t PRODUCTION-v${VERSION_NUMBER} -n "" --target "master"

echo "Finished."
