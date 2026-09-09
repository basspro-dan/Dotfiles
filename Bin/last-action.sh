#!/usr/bin/bash

NAMES=($(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
for NAME in "${NAMES[@]}" ; do                   # Set up our loop.
cd $NAME

LineOut=$(gh run list | grep 'Lint Terraform' | head -1 | grep -E 'failure|success')

echo $NAME : $LineOut

cd ..
done
