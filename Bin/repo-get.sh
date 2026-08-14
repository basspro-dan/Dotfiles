#!/usr/bin/bash


gh api user/memberships/orgs --jq '.[].organization.login' 

