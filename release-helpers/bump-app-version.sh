#!/bin/bash

echo "1. Git stash - to prevent work loss"
DATE_STRING=$(date '+%Y-%m-%d_%H-%M-%S')
git stash push -u -m stash-${DATE_STRING}

echo "2. Checkout"
git checkout develop

echo "3. Pulling"
git pull

echo "4. Bumping app version and assigning it to variable"
VERSION_JSON=`yarn version --minor --json --no-git-tag-version | grep New`
VERSION_NUMBER=$(echo $VERSION_JSON | jq '.data' | sed 's/New version: //g' | tr -d '"')
echo "New version number: $VERSION_NUMBER"

echo "5. Creating branch to bump version"
git checkout -b version-${VERSION_NUMBER}-bump

echo "6. Adding files"
git add .

echo "7. Committing"
git commit -m "Bump app version"

echo "8. Pushing to remote"
git push --set-upstream origin version-${VERSION_NUMBER}-bump

echo "9. Create PR for app version bump"
PR_LINK=$(gh pr create --title "Bump app version" --base develop --body "Bump app version" | grep "pull/")

echo "10. Check out develop"
git checkout develop

echo "Finished."
