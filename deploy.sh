#!/usr/bin/env bash

# amazing improvement over existing deploy script:

bundle exec middleman build --clean
mkdir -p docs
cp -r build/* docs/
rm -r build
git commit -am "Deploy script: adding docs"

git push --quiet origin master
