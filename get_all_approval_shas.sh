#!/usr/bin/env bash

REPOS="api process"

for repo in $REPOS ; do
    echo -en "$repo: "
    gh api repos/RedHatInsights/approval-$repo/commits/${BRANCH:-master} | \
        jq .sha | \
        tr -d '"' | \
        awk '{print substr($1,0,7)}'
done
