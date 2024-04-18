#!/bin/bash
set -e
DB_NAME=${1:-loganalyzer}
DB_USER=${2:-logan}
DB_USER_PASS=${3:-admin}
sudo mysql<<EOF
CREATE USER $DB_USER@'localhost' IDENTIFIED BY '$DB_USER_PASS';
CREATE DATABASE $DB_NAME;
USE $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'localhost' WITH GRANT OPTION;
flush privileges;
EOF
