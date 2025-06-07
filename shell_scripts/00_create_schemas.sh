#!/usr/bin/env bash
set -euo pipefail


HOST="localhost"
PORT="5435"
USER="admin"
DB="bearwulf"
export PGPASSWORD="pgadmin_bear"

SQL_FILE="initdb/00-create-schemas.sql"

if [[ ! -f "$SQL_FILE" ]]; then
  echo "Error: $SQL_FILE not found."
  exit 1
fi

echo "Running schema creation script: $SQL_FILE"
psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB" -f "$SQL_FILE"

echo "Schemas created successfully."