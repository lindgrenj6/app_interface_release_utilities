#!/usr/bin/env bash
set -euo pipefail

export RUNNER=$(which podman) || "docker"
export IMAGE=$(oc get po $(oc get po | grep $1 | awk '{print $1}') -o json | jq .spec.containers[0].image | tr -d '"')
# echo "Inspecting ${IMAGE}..."

$RUNNER run -it --rm --entrypoint cat $IMAGE $2
