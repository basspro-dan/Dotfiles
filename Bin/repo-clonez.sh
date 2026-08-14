#!/usr/bin/bash
set -euo pipefail

gh api user/memberships/orgs --paginate --jq '.[].organization.login' |
while IFS= read -r ORG; do

    echo "===== $ORG ====="
    mkdir -p "$ORG"
    (
        cd "$ORG"
        gh repo list "$ORG" --limit 1000 --json name --jq '.[].name' | xargs -I{} gh repo clone "$ORG/{}"
    )
    echo
done

## This is an update to repo-clone-orgz.sh No work is required except clone except 
## to have access to orgs in github. Every repo in every Org will be cloned. 
