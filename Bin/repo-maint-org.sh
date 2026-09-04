#!/usr/bin/bash

NAMES=($(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
for NAME in "${NAMES[@]}" ; do                   # Set up our loop.
echo "Processing : $ORG/$NAME"
cd $NAME
git checkout $( git symbolic-ref refs/remotes/origin/HEAD | cut -d / -f4 )
git fetch --all && git pull

cd ..
done
