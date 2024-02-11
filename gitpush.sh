#!/bin/bash
gitusername="MuyleangIng"
gittoken="swdfghj"    
gitUrl="github.com/$gitusername"


if [ -d ".git" ]; then
    echo "Git repo exists"
    git add .
    git commit -m "Update helm chart"
    git push
     git push --set-upstream origin main 

    exit 0
fi
echo "Starting repository script"
read -p "Enter repository: " nameRepo
if [ -z "$nameRepo" ]; then
  echo "repository cannot be empty. Exiting."
  exit 1
fi
echo "Name of repository is $nameRepo"
# Execute curl command and capture HTTP status code
http_status=$(curl -s -o /dev/null -w "%{http_code}" -L -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: Bearer $gittoken" \
  "https://api.github.com/user/repos" \
  -d "{\"name\":\"$nameRepo\",\"description\":\"This is your first repository\",\"homepage\":\"https://github.com\",\"private\":false,\"has_issues\":true,\"has_projects\":true,\"has_wiki\":true}")

# Check if the repository was created successfully
if [ "$http_status" -eq 201 ]; then
    echo "Repository created successfully."
else
    echo "Failed to create repository. HTTP status: $http_status"
    exit 1
fi

# curl -L \
#   -X POST \
#   -H "Accept: application/vnd.github.v3+json" \
#   -H "Authorization: token $gittoken" \
#   https://api.github.com/user/repos \
#   -d "{\"name\":\"$nameRepo\",\"description\":\"This is your first repository\",\"homepage\":\"https://github.com\",\"private\":false,\"has_issues\":true,\"has_projects\":true,\"has_wiki\":true}"


echo "# $nameRepo" >> README.md
git init 
git add .
git branch -M main
git commit -m "update"
git remote add origin "https://${gitUrl}/${nameRepo}.git"
git push https://${gitusername}:${gittoken}@${gitUrl}/${nameRepo}.git
echo "Done"
