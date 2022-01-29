#!/bin/bash

# adjust working directory
if [[ -f empty_commit.sh ]]  # in scripts dir
then
  cd ..
fi

# git
git add .
git commit -m 'save'
git push