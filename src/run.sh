#! /bin/sh

set -eu

source ./repository.sh

create_repository

if [ "$S3_S3V4" = "yes" ]; then
  aws configure set default.s3.signature_version s3v4
fi

if [ -z "$SCHEDULE" ]; then
  sh backup.sh
else
  exec go-cron "$SCHEDULE" /bin/sh snapshot.sh
fi
