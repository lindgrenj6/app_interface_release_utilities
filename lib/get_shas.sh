#!/usr/bin/env bash

BRANCH=${BRANCH:-stable}
echo "Branch: ${BRANCH}"

for repo in $REPOS ; do
    echo -en "$repo${SEPARATOR:-": "}"
    gh api repos/RedHatInsights/$PREFIX-$repo/commits/$BRANCH | \
        jq .sha   | \
        tr -d '"' | \
        awk '{print substr($1,0,7)}'
done
