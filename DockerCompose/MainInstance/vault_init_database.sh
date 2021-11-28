export VAULT_ADDR=http://localhost:8200

vault login myroot
vault secrets enable database

vault write database/config/my-mysql-database \
    plugin_name=mysql-database-plugin \
    connection_url="${$DATABASE_USERNAME}:${DATABASE_PASSWORD}@tcp(${DATABASE_URL})/" \
    allowed_roles="my-role-short","my-role-long" \
    username="vaultuser" \
    password="vaultpass"


vault write database/roles/my-role-long \
    db_name=my-mysql-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON alchemy.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

vault write database/roles/my-role-short\
    db_name=my-mysql-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON alchemy.* TO '{{name}}'@'%';" \
    default_ttl="3m" \
    max_ttl="6m"

