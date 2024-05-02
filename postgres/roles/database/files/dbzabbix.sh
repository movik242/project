#!/bin/bash
set -e
DB_NAME=${1:-zabbix}
DB_USER=${2:-zabbix}
DB_USER_PASS=${3:-admin}
sudo su postgres <<EOF
psql -c "CREATE ROLE $DB_USER CREATEDB CREATEROLE LOGIN;"
psql -c "ALTER USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
EOF
