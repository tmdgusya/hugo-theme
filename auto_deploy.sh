#!/bin/bash

# 1. Build the project using hugo
hugo -t terminal

# 2. Go To Public folder
cd public

# 3. Add changes to git.
git add .

# 4. Commit changes.
msg="rebuilding site $(date)"

# 5. Push source and build repos.
git commit -m "$msg"
git push origin main

if [ $# -eq 1 ]
  then msg="$1"
fi
