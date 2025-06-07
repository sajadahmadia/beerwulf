#!/usr/bin/env bash
set -euo pipefail

HOST="localhost"
PORT="5435"
USER="admin"
DB="bearwulf"
export PGPASSWORD="pgadmin_bear"

tables=(
  region
  nation
  part
  supplier
  partsupp
  customer
  orders
  lineitem
)

for table in "${tables[@]}"; do
  file="data/${table}.tbl"
  if [[ ! -f "$file" ]]; then
    echo "Warning: source file $file not found, skipping $table"
    continue
  fi

  file_lines=$(wc -l < "$file")


  actual=$(psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB" -tAc "SELECT count(*) FROM landing_zone.${table};")

  if [[ "$actual" -ne "$file_lines" ]]; then
    echo "ERROR: Table landing_zone.$table has $actual rows, file_lines $file_lines (from file)."
    exit 1
  else
    echo "OK: landing_zone.$table → $actual rows (matches file_lines $file_lines)."
  fi
done

echo "All table row counts match their source files."