#!/usr/bin/bash

# The purpose of this script is to update all local git repositories by performing a 'git fetch' and 'git pull'
# It's ugly but it works. This assumes you have your repos organized by org/repo.

ORGZ=($(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
for ORG in "${ORGZ[@]}" ; do                   # Set up our loop. 
echo "" ; date ; echo ""
echo "Processing : $ORG"    
cd $ORG


NAMES=($(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
for NAME in "${NAMES[@]}" ; do                   # Set up our loop. 
echo "Processing : $ORG/$NAME"
cd $NAME
git checkout $( git symbolic-ref refs/remotes/origin/HEAD | cut -d / -f4 )
git fetch --all && git pull

cd ..   
done

cd ..
done
