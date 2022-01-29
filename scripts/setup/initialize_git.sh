#!/bin/bash

#
# Created by Daniel Nazarian on 11/14/21, 9:02 PM
# Copyright (c) Daniel Nazarian. 2021 . All rights reserved.
#
# Please do NOT use, edit, distribute, or otherwise use this code without consent.
# For questions, comments, concerns, and more -> dnaz@danielnazarian.com
#

echo "=========================================="
echo "initialize_git.sh"
echo "by Daniel Nazarian"
echo
echo "This script is designed to start your GitHub"
echo "repository for your project."
echo "This should be run ONLY from your NEW project"
echo "directory i.e., not the bootstrapper."
echo
echo "NOTE: GitHub CLI is REQUIRED to run this script."
echo

# adjust working directory - expected to be in project root
if [[ -f empty_commit.sh ]]; then # in scripts dir
  cd ..
fi
if [[ -f initialize.sh ]]; then # in setup dir
  cd ../..
fi

echo "clear existing git..."
rm -rf '.git'
echo

echo "Checking GitHub CLI is installed..."
if ! command -v gh &>/dev/null; then
  echo "gh command could not be found"
  exit 1
fi

echo -n "What do you want to call this repo?"
echo "NOTE: it is HIGHLY recommended to make this your samsshack from the initialize script [ENTER]: "
read -r repo_name

# start git repo
echo "Initialize local repo..."
git init
git add .
git commit -m 'initial commit'

echo "Creating GitHub repository..."
gh repo create "Dan-Incorporated/${repo_name}" --public

echo "Add origin..."
git remote add origin "https://github.com/Dan-Incorporated/${repo_name}"

echo "Finalize and pushing..."
git push --set-upstream origin master

echo "Successfully created GitHub repository!"
