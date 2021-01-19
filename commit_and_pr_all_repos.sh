#!/usr/bin/env bash
set -euo pipefail

REPOS="approval/api/ catalog/api/ sources/api/ sources/monitor topo/ansible_tower/ topo/api/ topo/azure/ topo/amazon/ topo/openshift/ topo/persister/ topo/satellite/ topo/orchestrator/ topo/ingress/ topo/sync topo/scheduler topo/google"

PREV="2.5"
NEW="2.6"
BRANCH_NAME=update_ubi_image

for i in $REPOS ; do
    (
        echo $i
        cd $i && \
            git co master && \
            git pull upstream master && \
            git push origin master && \
            git co -b ${BRANCH_NAME} && \
            sed -i "s/${PREV}/${NEW}/g" Dockerfile
            git add Dockerfile && \
            git commit -m "$1" && \
            gh pr create -t "$1" -b "$2"
    )
done
