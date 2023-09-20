#!/usr/bin/env bash

set -eu

source ./env.sh

if [ "$S3_S3V4" = "yes" ]; then
  aws configure set default.s3.signature_version s3v4
fi

if [ -z "$SCHEDULE" ]; then
  python3 main.py snapshot
else
  python3 main.py
  uvicorn server:app
fi
