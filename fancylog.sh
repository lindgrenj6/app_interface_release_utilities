#!/usr/bin/env bash
set -euo pipefail

export POD=$(k get po | grep $1 | awk '{print $1}')

if [[ "${POD}" == "" ]] ; then
    echo "Couldn't match pod with '$1'"
    exit 1
fi

kubectl logs -f $POD | grep '^{' | jq -r .
