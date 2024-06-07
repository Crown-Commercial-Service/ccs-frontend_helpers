#!/bin/sh
set -e

# Check if there are unexpected changes. Changes to CHANGELOG.md, version.rb
# and Gemfile.lock files are expected as part of the normal release process.
changes="$(git status --porcelain -- ':!CHANGELOG.md' ':!lib/ccs/frontend_helpers/version.rb' ':!Gemfile.lock')"
if [[ -n $changes ]]; then
  echo "⚠ Unexpected changes in your working directory:"
  echo "$changes"
  exit 1
fi

echo "Starting to build release..."
echo " "
echo "This will:"
echo "- run the test suite"
echo "- commit all changes and push the branch to remote"
echo " "

read -r -p "Do you want to continue? [y/N] " continue_prompt

if [[ $continue_prompt != 'y' ]]; then
    echo "Cancelling build, if this was a mistake, try again and use 'y' to continue."
    exit 0
fi

bundle exec rake

ALL_PACKAGE_VERSION=$(./bin/version)
TAG="v$ALL_PACKAGE_VERSION"
CURRENT_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

if [ $(git tag -l "$TAG") ]; then
    echo "⚠️ Git tag $TAG already exists."
    exit 1;
else
    git add .
    git commit -m "Release $TAG"
    # set upstream so that we can push the branch up
    git push --set-upstream origin $CURRENT_BRANCH_NAME
    git push
    echo "🗒 All done. Ready to create a pull request. Once approved, merge and the release will made automatically"
fi
