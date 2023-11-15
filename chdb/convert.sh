#!/bin/bash

PROVIDER="${PROVIDER:-github_runner}"
MACHINE="${MACHINE:-2vCPU_7GB}"

RESULTS=$(cat log.txt | grep -P '^\d|Killed|Segmentation' | sed -r -e 's/^.*(Killed|Segmentation).*$/null\nnull\nnull/' |     awk '{ if (i % 3 == 0) { printf "[" }; printf $1; if (i % 3 != 2) { printf "," } else { print "]," }; ++i; }') # >> results.json

mkdir -p results

VERSION=$(python -m chdb "SELECT version()" | tr -d '"')

echo '{
    "system": "chdb",
    "date": "'$(date +%F)'",
    "machine": "'$PROVIDER $MACHINE'",
    "cluster_size": "serverless",
    "comment": "'$VERSION'",
    "tags": ["C++", "column-oriented", "ClickHouse derivative", "embedded", "github"],
    "load_time": 0,
    "data_size": 0,
    "result": [
      '$(echo $RESULTS | head -c-2)'
    ]
}
' > "results/${PROVIDER}.${MACHINE}.json"
