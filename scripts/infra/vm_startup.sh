#!/bin/bash
set -e

# Update and install dependencies
apt-get update
apt-get install -y postgresql postgresql-contrib debian-keyring debian-archive-keyring apt-transport-https curl

# Install Caddy
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
apt-get update
apt-get install -y caddy

# Configure Postgres
# 1. Allow listening on all interfaces (controlled by firewall/Caddy later)
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf

# 2. Allow password authentication
echo "host    all             all             0.0.0.0/0            scram-sha-256" >> /etc/postgresql/*/main/pg_hba.conf

# 3. Restart Postgres
systemctl restart postgresql

# 4. Fetch Passwords from Metadata
PASS_PROD=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_password_prod 2>/dev/null || echo "prod_pass_default")
PASS_DEV=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_password_dev 2>/dev/null || echo "dev_pass_default")

# 5. Create Databases and Users
# Production
sudo -u postgres psql -c "CREATE USER prod_user WITH PASSWORD '$PASS_PROD';"
sudo -u postgres psql -c "CREATE DATABASE family_tree_prod OWNER prod_user;"
sudo -u postgres psql -c "ALTER USER prod_user CREATEDB;"

# Development (Secondary)
sudo -u postgres psql -c "CREATE USER dev_user WITH PASSWORD '$PASS_DEV';"
sudo -u postgres psql -c "CREATE DATABASE family_tree_dev OWNER dev_user;"
sudo -u postgres psql -c "ALTER USER dev_user CREATEDB;"

# Setup Backup Directory
mkdir -p /opt/backups
chown postgres:postgres /opt/backups
