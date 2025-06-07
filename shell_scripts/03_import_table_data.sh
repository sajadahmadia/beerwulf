#!/usr/bin/env bash

export PGPASSWORD="pgadmin_bear"

for file in data/data_clean/*_clean.tbl; do
  table=$(basename "$file" _clean.tbl)
  echo "importing $table into landing_zone.$table..."
  psql -h localhost -p 5435 -U admin -d bearwulf \
    -c "\copy landing_zone.${table} FROM '${file}' DELIMITER '|' NULL ''"
done

echo "import completed"