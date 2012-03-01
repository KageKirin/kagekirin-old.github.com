#!/bin/bash

echo "saving site changes"
git add _config.yml
git commit -m "updated _config.yml"
git add sass
git commit -m "updated stylesheets"
git add source
git commit -m "updated blog pages"
git commit -am "saved other changes"

echo "syncing with remote origin"
git pull origin source

echo "updating octopress"
git pull octopress master

echo "regenerating site"
rake generate
rake deploy

echo "deploying site"
git add . 
git commit -am "regenerated blog"
git push origin source
