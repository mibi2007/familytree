# Set PostgreSQL password and run update for Windows environment
export PGPASSWORD='postgres'
psql -U postgres -d familytree -c "UPDATE users SET role = 'SUPER_ADMIN' WHERE id = '0uqicc1sPBdqSEh6Uv7PcrlIe8Ao';"
