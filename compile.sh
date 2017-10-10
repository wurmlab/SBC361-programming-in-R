#!/bin/bash

set -o errexit -o nounset

year=$(date +"%Y")

cd $year
echo "Converting markdown files in $year/ to html"
for i in *md; do
  if [[ $i != 'README.md' ]]; then
    pandoc -f markdown_github -c ../theme.css -s $i -o ../public/${i%%md}html;
  fi
done
cd ..
