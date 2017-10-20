#!/bin/bash
# From https://gist.github.com/bmpvieira/ae0d9f9e6cff3df831cc5b6511207138 and modified

# Exit with nonzero exit code if anything fails
set -ex

REPO_URL="https://$GH_TOKEN@github.com/wurmlab/SBC361-programming-in-R.git"

SOURCE_BRANCH="master"; TARGET_BRANCH="gh-pages"

SHA=`git rev-parse --verify HEAD`

function doCompile {
  ./compile.sh
}

doCompile

if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "This is a pull request or a feature branch - skipping deploy"
    exit 0
fi

echo "Fetching website content"
cd public
git init .
git remote add deploy $REPO_URL
git fetch deploy $TARGET_BRANCH
git reset deploy/$TARGET_BRANCH

git add --all .
git config user.name "Anurag Priyam"
git config user.email "anurag.priyam@qmul.ac.uk"

git commit -m "Deploy ${SHA}"
echo "Now that we're all set up, we can push."
git push deploy HEAD:gh-pages
