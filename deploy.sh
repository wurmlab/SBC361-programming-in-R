#!/bin/bash
# From https://gist.github.com/bmpvieira/ae0d9f9e6cff3df831cc5b6511207138 and modified
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="master"; TARGET_BRANCH="gh-pages"

function doCompile {
  ./compile.sh
}

echo "Pull requests and commits to other branches shouldn't try to deploy, just build to verify"
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi

echo "Save some useful information"
REPO_URL="https://$GH_TOKEN@github.com/wurmlab/SBC361-programming-in-R.git"
SHA=`git rev-parse --verify HEAD`

echo "Run our compile script"
doCompile

echo "Clone the existing gh-pages for this repo into public/"
cd public
git remote add deploy $REPO_URL
git fetch deploy $TARGET_BRANCH
git reset deploy/$TARGET_BRANCH

echo "If there are no changes to the compiled out (e.g. this is a README update) then just bail."
if [[ -z `git diff --exit-code` ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

echo 'Commit the "changes", i.e. the new version.'
echo "The delta will show diffs between new and old versions."
git add --all .
git config user.name "lrsantiago"
git config user.email "l.santiago@qmul.ac.uk"
git commit -m "Deploy to GitHub Pages: ${SHA}"

echo "Now that we're all set up, we can push."
git push deploy HEAD:gh-pages
