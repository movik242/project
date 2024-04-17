#!/bin/bash
set -e
DB_NAME=${1:-zabbix}
sudo su zabbix <<EOF
createdb  $DB_NAME;
EOF
