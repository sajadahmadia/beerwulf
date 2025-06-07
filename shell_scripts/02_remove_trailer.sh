#!/usr/bin/env bash

mkdir -p data/data_clean

for file in data/*.tbl; do
  base=$(basename "$file" .tbl)
  sed 's/|$//' "${file}" > "data/data_clean/${base}_clean.tbl"
done

echo "Cleaned files are in data/data_clean"