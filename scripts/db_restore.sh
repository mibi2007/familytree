#!/bin/bash
FILE=$1
DB_NAME="familytree"
DB_USER="postgres"

if [ -z "$FILE" ]; then
    # Get latest backup if file not specified
    FILE=$(ls -t backups/*.sql 2>/dev/null | head -n 1)
    if [ -z "$FILE" ]; then
        echo -e "\e[31mNo backup file found in 'backups/' directory.\e[0m"
        exit 1
    fi
fi

echo -e "\e[36mRestoring database '$DB_NAME' from $FILE...\e[0m"

# Terminate connections to drop database if needed, then recreate
psql -U $DB_USER -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid();"
psql -U $DB_USER -c "DROP DATABASE IF EXISTS $DB_NAME;"
psql -U $DB_USER -c "CREATE DATABASE $DB_NAME;"

# Restore
psql -U $DB_USER -d $DB_NAME -f "$FILE"

if [ $? -eq 0 ]; then
    echo -e "\e[32mRestore successful!\e[0m"
else
    echo -e "\e[31mRestore failed!\e[0m"
fi
