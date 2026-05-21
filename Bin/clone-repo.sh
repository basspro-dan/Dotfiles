#!/usr/bin/bash

gh repo list $1  --limit 4000 | while read -r repo _; do
gh repo clone "$repo" "$repo"
#echo $repo
done
