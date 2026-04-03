#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 OWNER/REPO"
  exit 1
fi

OWNER_REPO="$1"
OWNER="${OWNER_REPO%/*}"
REPO="${OWNER_REPO#*/}"

# Fetch all workflow runs via the REST API and paginate through all pages.
# Endpoint: GET /repos/{owner}/{repo}/actions/runs
# - We extract only the fields we care about: actor.login and created_at
# - Then slurp into an array and group in jq
gh api --paginate "/repos/${OWNER}/${REPO}/actions/runs?per_page=100" \
  -H "Accept: application/vnd.github+json" \
  --jq '.workflow_runs[] | {user: .actor.login, created_at}' \
| jq -s '
  # Convert created_at -> YYYY-MM, then group by user and month
  map({user, month: (.created_at | fromdateiso8601 | strftime("%Y-%m"))})
  | sort_by(.user, .month)             # ensure stable order before group_by
  | group_by(.user)
  | .[]                                 # each user group
  | {
      user: .[0].user,
      months:
        ( group_by(.month)
        | map({month: .[0].month, count: length})
        | sort_by(.month)               # ascending by YYYY-MM; use | reverse for latest first
        )
    }
  | .user as $u
  | "User: \($u), " +
    ( .months | map("  " + .month + ": " + (.count|tostring)) | join("") ) + ""
'
