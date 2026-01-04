#!/bin/bash
DB_NAME="familytree"
DB_USER="postgres"
BACKUP_DIR="backups"
DATE=$(date +"%Y%m%d_%H%M%S")
FILE_NAME="$BACKUP_DIR/db_$DATE.sql"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

echo -e "\e[36mBacking up database '$DB_NAME' to $FILE_NAME...\e[0m"

# Ensure pg_dump is in path
pg_dump -U $DB_USER -d $DB_NAME -f $FILE_NAME

if [ $? -eq 0 ]; then
    echo -e "\e[32mBackup successful!\e[0m"
else
    echo -e "\e[31mBackup failed!\e[0m"
fi
