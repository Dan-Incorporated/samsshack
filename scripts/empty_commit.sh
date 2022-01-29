#!/bin/bash

# adjust working directory
if [[ -f empty_commit.sh ]]  # in scripts dir
then
  cd ..
fi

git commit --allow-empty -m "Empty commit"
git push