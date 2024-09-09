#!/bin/bash

# create template
# stack install hakyll

# cd ~/git/hakyll

# ~/.local/bin/hakyll-init auroracollective
# stack new auroracollective hakyll-template # keep getting problems with this one

# cd auroracollective
# git add origin git@github.com:auroracollective/auroracollective.github.io.git

#  rm -rf /Users/soutomaiormenc2/.stack/precompiled/x86_64-osx/ghc-8.4.3/2.2.0.1/haddock-library-1.5.0.1\@sha256\:bbfba77cecd79afb92b6f9eb43d08e092000e91638df1f265b1f061c20bd5f3a\,4684/
# https://github.com/commercialhaskell/stack/issues/4071

# stack init  # creates stack.yaml file based on my-site.cabal

# stack build

# stack exec site build
# stack exec site watch  # http://127.0.0.1:8000/.

#pass custom home dir as argument
GITDIR=$1
COPY=$2

# Temporarily store uncommited changes
cd $GITDIR/auroracollective.github.io/src
#git stash

# Verify correct branch
git checkout develop
if [ $COPY = true ]; then
    cp -r $GITDIR/auroracollective.github.io/src $GITDIR/auroracollective.github.io/copy
    rm -rf $GITDIR/auroracollective.github.io/copy/.stack-work
fi

# git stage <modified files here>
git stage .
git commit -m "hakyll build"
git push origin develop

# Build new files
stack exec site clean
stack exec site build
# stack exec site watch

# Get previous files
#git fetch --all
cd ..
git checkout main # --track origin/main

# Overwrite existing files with new files
# cp -archive _site/. ../
cp -a src/_site/. .

# Commit
git stage -A
git commit -m "publish"

# Push
git push origin main
git checkout develop

# Restoration
#git checkout develop
#git branch -D main
#git stash pop
