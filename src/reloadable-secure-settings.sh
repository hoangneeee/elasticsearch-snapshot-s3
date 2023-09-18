#! /bin/sh

set -eu
set -o pipefail

source ./env.sh

## https://www.elastic.co/guide/en/elasticsearch/reference/8.9/secure-settings.html
#
curl -u "$ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD" -X POST "$ELASTICSEARCH_HOST/_snapshot/$ELASTICSEARCH_REPO_NAME" -H 'Content-Type: application/json'

curl -u "elastic:changeme" -X POST "localhost:9200/_nodes/reload_secure_settings?pretty" -H 'Content-Type: application/json' -d'
{
  "secure_settings_password": "protocol"
}'
