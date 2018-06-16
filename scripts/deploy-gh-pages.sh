#!/bin/sh
# ideas used from https://gist.github.com/motemen/8595451

# Based on https://github.com/eldarlabs/ghpages-deploy-script/blob/master/scripts/deploy-ghpages.sh
# Used with their MIT license https://github.com/eldarlabs/ghpages-deploy-script/blob/master/LICENSE

# abort the script if there is a non-zero error
set -e

# show where we are on the machine
git config --global user.email "$GH_EMAIL" > /dev/null 2>&1
git config --global user.name "$GH_NAME" > /dev/null 2>&1
remote=$(git config remote.origin.url)

pwd
# make a directory to put the gp-pages branch
echo "Current folder"
pwd
git clone git@github.com:misky1986/hugo-blog.git
cd hugo-blog

echo "Current folder"
pwd

echo "Building hugo site"
hugo
echo "Finished building hugo site"
ls -al

echo "Deleting all other files and folder the public and .git"
find . -maxdepth 1 ! -name 'public' ! -name '.git' -exec rm -rf {} \;
ls -al

echo "moving all files and folders within public one level up"
mv public/* .
ls -al

echo "Deleting empty public folder"
rm -rf public 
ls -al

echo "Checking out gh-pages branch"
git checkout gh-pages

echo "Git status"
git status

echo "Add all files"
git add -A

echo "Add all files"
git commit -m "Automated deployment to GitHub Pages: ${CIRCLE_SHA1}"
git push origin gh-pages
echo "Finished Deployment!"
