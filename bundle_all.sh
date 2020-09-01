#!/usr/bin/env bash

for i in $(find . -name Gemfile | grep -v vendor | grep -v .bundle | sed 's$Gemfile$$g'); do
    (
        cd $i && \
        echo "------ $i ------------------------------------" && \
        bundle update && bundle clean
    )
done
