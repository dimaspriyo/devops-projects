#!/bin/bash

sleep 30

curl -v -X POST -H 'Content-Type: application/json' -d ' { "name":"api-key", "role":"Admin", "secondsToLive":86400 }' http://admin:admin@grafana:3000/api/auth/keys && curl -v -X POST  -H "Content-Type: application/json" -d @datasources/redis-source.json http://127.0.0.1:3000/api/datasources
# wget --no-check-certificate --quiet --timeout=0 --header='Content-Type: application/json' --post-data='{ "name":"api-key", "role":"Admin", "secondsToLive":86400}' 'http://admin:admin@grafana:3000/api/auth/keys'

# curl -v -X POST -H 'Content-Type: application/json' -d ' { "id":null, "orgId":1, "folderId":null, "overwrite":false, "dashboard":{ "id":null, "uid":null, "title":"Sample Dashboard", "timezone":"browser", "schemaVersion":27, "version":0, "time":{"from":"now-6h","to":"now"}, "refresh":"10s", "panels":[], "annotations":{ "list":[] }, "hideControls":false }, "folderId":0, "overwrite":false }' http://admin:admin@grafana:3000/api/dashboards/db
# wget --no-check-certificate --quiet --timeout=0 --header='Content-Type: application/json' --post-data=' { "id":null, "orgId":1, "folderId":null, "overwrite":false, "dashboard":{ "id":null, "uid":null, "title":"Sample Dashboard", "timezone":"browser", "schemaVersion":27, "version":0, "time":{"from":"now-6h","to":"now"}, "refresh":"10s", "panels":[], "annotations":{ "list":[] }, "hideControls":false }, "folderId":0, "overwrite":false }' 'http://admin:admin@grafana:3000/api/dashboards/db'


# Function to create Grafana API key
create_api_key() {
  local api_key_name=$1

  echo "Creating API key: $api_key_name"
  curl -X POST -H "Authorization: Bearer admin_password" -H "Content-Type: application/json" \
    -d "{\"name\": \"$api_key_name\", \"role\": \"$api_key_role\"}" http://127.0.0.1:3000/auth/keys
}

# Create predefined service accounts
create_api_key "admin" "Admin"
# Add more service accounts as needed