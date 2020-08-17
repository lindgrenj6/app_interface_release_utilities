#!/usr/bin/env bash

REPOS="ansible_tower api azure amazon openshift persister satellite orchestrator ingress_api sync"

for repo in $REPOS ; do
    echo -en "$repo: "
    gh api repos/RedHatInsights/topological_inventory-$repo/commits/${BRANCH:-master} | \
        jq .sha | \
        tr -d '"' | \
        awk '{print substr($1,0,7)}'
done
