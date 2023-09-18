#! /bin/sh

set -eu
set -o pipefail

source ./env.sh

echo "Creating snapshot of $ELASTICSEARCH_INDEX_NAME indexes..."

timestamp=$(date +"%Y-%m-%dt%H:%M:%S")

## Create snapshot
## https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html
#
if [ -z "$ELASTICSEARCH_USERNAME" ]; then
  curl -X PUT "$ELASTICSEARCH_HOST/_snapshot/$ELASTICSEARCH_REPO_NAME/${ELASTICSEARCH_INDEX_NAME}_${timestamp}" -H 'Content-Type: application/json' -d '{
    "indies": "'$ELASTICSEARCH_INDEX_NAME'",
    "ignore_unavailable": true,
    "include_global_state": false,
    "metadata": {
      "taken_by": "'$ELASTICSEARCH_USERNAME'",
      "taken_because": "backup schedule"
    }
  }'
else
  curl -u "$ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD" -X PUT "$ELASTICSEARCH_HOST/_snapshot/$ELASTICSEARCH_REPO_NAME/${ELASTICSEARCH_INDEX_NAME}_${timestamp}" -H 'Content-Type: application/json' -d '{
    "indies": "'$ELASTICSEARCH_INDEX_NAME'",
    "ignore_unavailable": true,
    "include_global_state": false,
    "metadata": {
      "taken_by": "'$ELASTICSEARCH_USERNAME'",
      "taken_because": "backup schedule"
    }
  }'
fi

