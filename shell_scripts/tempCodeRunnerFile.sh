#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.dbt

cat > ~/.dbt/profiles.yml <<EOF
beerwulf_profile:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: admin
      password: pgadmin_bear
      port: 5435
      dbname: bearwulf
      schema: staging
      threads: 4
      keepalives_idle: 0
EOF

echo "~/.dbt/profiles.yml has been created."