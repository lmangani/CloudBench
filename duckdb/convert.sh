#!/bin/bash

PROVIDER="${PROVIDER:-github_runner}"
MACHINE="${MACHINE:-2vCPU_7GB}"

cat log.txt | grep -P '^\d|Killed|Segmentation' | sed -r -e 's/^.*(Killed|Segmentation).*$/null\nnull\nnull/' | awk '{ if (i % 3 == 0) { printf "[" }; printf $1; if (i % 3 != 2) { printf "," } else { print "]," }; ++i; }' > dump.json 
RESULTS=$(cat dump.json)
rm -rf dump.json

mkdir -p results

VERSION=$(python3 -c "import duckdb; print(duckdb.__version__)")

echo '{
    "system": "DuckDB",
    "date": "'$(date +%F)'",
    "machine": "'$PROVIDER $MACHINE'",
    "cluster_size": "serverless",
    "comment": "'$VERSION'",
    "tags": ["C++", "column-oriented", "embedded", "github"],
    "load_time": 0,
    "data_size": '$(find . -type f -name "*.parquet" -print0 | xargs -0r du -cb | tail -n1 | awk '{print $1}')',
    "result": [
      '$(echo $RESULTS | head -c-2)'
    ]
}
' > "results/${PROVIDER}.${MACHINE}.json"
