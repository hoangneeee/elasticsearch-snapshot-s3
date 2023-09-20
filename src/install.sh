#! /bin/sh

set -eux
set -o pipefail

apk update && apk add --no-cache bash && apk add python3 && apk add curl
# apk add gnupg
apk add py3-pip  # separate package on edge only
pip3 install awscli
pip3 install -r requirements.txt

# cleanup
rm -rf /var/cache/apk/*
