#! /bin/sh

set -eu
set -o pipefail

source ./env.sh

## Create repository on elastic search
# https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html
#
function create_repository {
  echo "Creating repository $ELASTICSEARCH_REPO_NAME on $ELASTICSEARCH_HOST..."

  if [ -z "$ELASTICSEARCH_USERNAME" ]; then
    curl -X PUT "$ELASTICSEARCH_HOST/_snapshot/$ELASTICSEARCH_REPO_NAME?pretty" -H 'Content-Type: application/json' -d'
      {
        "type": "s3",
        "settings": {
          "bucket": "'$S3_BUCKET'",
          "base_path": "'$S3_PREFIX'"
        }
      }'
  else
    curl -u "$ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD" -X PUT "$ELASTICSEARCH_HOST/_snapshot/$ELASTICSEARCH_REPO_NAME?pretty" -H 'Content-Type: application/json' -d'
      {
        "type": "s3",
        "settings": {
          "bucket": "'$S3_BUCKET'",
          "base_path": "'$S3_PREFIX'"
        }
      }'
  fi

  }
