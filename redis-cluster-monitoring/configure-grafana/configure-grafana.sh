#!/bin/bash

sleep 30

curl -v -X POST -H 'Content-Type: application/json' -d ' { "name":"api-key", "role":"Admin", "secondsToLive":86400 }' http://admin:admin@grafana:3000/api/auth/keys && curl -v -X POST  -H "Content-Type: application/json" -d @datasources/redis-source.json http://grafana:3000/api/datasources

# Function to create Grafana API key
create_api_key() {
  local api_key_name=$1

  echo "Creating API key: $api_key_name"
  curl -X POST -H "Authorization: Bearer admin_password" -H "Content-Type: application/json" \
    -d "{\"name\": \"$api_key_name\", \"role\": \"$api_key_role\"}" http://grafana:3000/auth/keys
}

# Create predefined service accounts
create_api_key "admin" "Admin"
# Add more service accounts as needed