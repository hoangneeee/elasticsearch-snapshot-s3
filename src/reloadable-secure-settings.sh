#!/usr/bin/env bash

set -eu
set -o pipefail

source ./env.sh

## Reload secure settings
## https://www.elastic.co/guide/en/elasticsearch/reference/8.9/secure-settings.html
#
function reload_secure_settings() {
    local -a args=( '-s' '-D-' '-m15' '-X' 'POST' "${ELASTICSEARCH_HOST}/_nodes/reload_secure_settings?pretty" )

    if [[ -n "${ELASTICSEARCH_PASSWORD:-}" ]]; then
    		args+=( '-u' "${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD}" )
    fi
    log "Reloadable secure settings..."
    curl "${args[@]}"
}

reload_secure_settings


