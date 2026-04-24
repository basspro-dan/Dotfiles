#!/usr/bin/bash

#cat ../refined-org-list.txt | while read Orgz; do
cat ../next-new_org-list.txt | while read Orgz; do

mkdir $Orgz ; cd $Orgz
gh repo list $Orgz --limit 1000 | awk '{print $1}' | xargs -L1 gh repo clone
cd ..

done
