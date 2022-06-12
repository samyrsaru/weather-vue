#!/usr/bin/env sh

# abort on errors
# set -e

# build
echo "npm run build";
npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

# git init
git add -A
git commit -m 'deploy'

# git config user.email "samyrsaru@gmail.com"
# git config user.name "Samyr Saru"

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git main

# if you are deploying to https://<USERNAME>.github.io/<REPO>
echo "git push";
git push -f git@github.com:samyrsaru/weather-vue.git master:gh-pages

cd -
