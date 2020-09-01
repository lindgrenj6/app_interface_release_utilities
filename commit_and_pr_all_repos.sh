#!/usr/bin/env bash

REPOS="approval/api/ catalog/api/ catalog/minion/ topo/sources-api/ topo/sources-monitor/ topo/ansible_tower/ topo/api/ topo/azure/ topo/amazon/ topo/openshift/ topo/persister/ topo/satellite/ topo/orchestrator/ topo/ingress/ topo/topological_inventory-sync"

for i in $REPOS ; do
    (
        echo $i
        cd $i && \
            git co master && \
            git pull upstream master && \
            git co -b update_ubi_image && \
            git apply CHANGEME && \
            git add Dockerfile && \
            git commit -m "$1" && \
            gh pr create -t "$1" -b "$2"
    )
done
