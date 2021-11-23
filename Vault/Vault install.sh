#!/bin/sh
sudo -i
set -o xtrace
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

docker run --rm -d --name vault -e VAULT_DEV_ROOT_TOKEN_ID=myroot -e 'VAULT_LOCAL_CONFIG={"listener": {"tcp": {"address": "0.0.0.0:10200", "tls_disable": true}},"ui": true,"api_addr":"http://127.0.0.1:8200", "inmem": {}, "default_lease_ttl": "1h", "max_lease_ttl": "8760h"}' -v "$PWD"/file:/vault/file -p 10200:8200 --cap-add=IPC_LOCK vault

docker exec -it vault /bin/sh < echo "\

export VAULT_ADDR=http://localhost:8200
export MYSQL_ENDPOINT=cloudschool.cyauuy59rgfa.eu-west-1.rds.amazonaws.com:3306

vault login myroot
vault secrets enable database

vault write database/config/my-mysql-database \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}:{{password}}@tcp(${MYSQL_ENDPOINT})/" \
    allowed_roles="my-role-short","my-role-long" \
    username="vaultuser" \
    password="vaultpass"


vault write database/roles/my-role-long \
    db_name=my-mysql-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

vault write database/roles/my-role-short\
    db_name=my-mysql-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON *.* TO '{{name}}'@'%';" \
    default_ttl="3m" \
    max_ttl="6m"
