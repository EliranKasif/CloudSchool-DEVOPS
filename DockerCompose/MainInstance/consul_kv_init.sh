consul kv put app/config/LOG_LEVEL "DEBUG"
consul kv put app/config/END_POINT "free-to-play-games-database.p.rapidapi.com"
consul kv put app/config/RAPID_API_KEY "fc010fb2aemshe9c83f856d3bae5p183940jsn675a512bbb3a"
consul kv put app/config/MYSQL_ENDPOINT "cloudschool.cyauuy59rgfa.eu-west-1.rds.amazonaws.com"
consul kv put app/config/SCHEMA_NAME "alchemy"
consul kv put app/config/VAULT_ENDPOINT $VAULT_ADDR
consul kv put app/config/VAULT_TOKEN  "myroot"
consul kv put app/config/VAULT_PATH_TO_CREDS "database/creds/my-role-short"
