#!/usr/bin/env bash

# Task 08: this script is intentionally buggy.
# Usage: ./scripts/batch-copy.sh DEST FILE...

destination=$1
shift

mkdir -p $destination

for file in $@
do
    cp $file $destination/
done
