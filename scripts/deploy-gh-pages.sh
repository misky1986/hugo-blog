#! /bin/bash
set -e # stop at first failing command

echo "Build new hugo site"
hugo -v
cd public

echo "Show files in public folder"
ls -al

echo "What folder are we in?"
pwd

git init
echo "Show files in public folder after git init command"
ls -al

git config --global user.email "$GH_EMAIL" > /dev/null 2>&1
git config --global user.name "$GH_NAME" > /dev/null 2>&1

echo "show git status"
git status

git add .

echo "show git status after add ."
git status

git commit -m "Deploy from CircleCI"

echo "Remote addedd ."
git remote add origin git@github.com:misky1986/hugo-blog.git

# use --quiet to avoid printing token in build logs
git push --force origin master:gh-pages