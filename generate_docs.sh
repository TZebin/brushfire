#!/bin/sh

if [ $TRAVIS_PULL_REQUEST -ne "false" ]; then
  exit 0
fi

GH_REF="https://${GH_TOKEN?:}@github.com/stripe/brushfire.git"

set -e

echo "Generating docs..."
cd $(dirname $0)
mvn clean scala:doc

cd ./target/site/scaladocs
git init

git config user.name "Travis-CI"
git config user.email "travis@stripe.com"
git add .
git commit -m "autogenerated scaladoc"

echo "Pushing docs to github..."
git push --force --quiet $GH_REF master:gh-pages > /dev/null 2>&1

echo "Done!"
