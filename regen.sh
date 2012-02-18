#!/bin/bash

echo "regenerating site"
git add _config.yml
git commit -m "updated _config.yml"
git add sass
git commit -m "updated stylesheets"
git add source
git commit -m "updated blog pages"
rake generate
rake deploy
git add . 
git commit -am "regenerated blog"
git push origin source
