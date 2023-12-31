
# Log a message.
function log {
	echo "[+] $1"
}

# Log a message at a sub-level.
function sublog {
	echo "   ⠿ $1"
}

# Log an error.
function err {
	echo "[x] $1" >&2
}

# Log an error at a sub-level.
function suberr {
	echo "   ⠍ $1" >&2
}

if [ -z "$S3_BUCKET" ]; then
  echo "You need to set the S3_BUCKET environment variable."
  exit 1
fi

if [ -z "$ELASTICSEARCH_INDEX_NAME" ]; then
  echo "You need to set the ELASTICSEARCH_INDEX_NAME environment variable."
  exit 1
fi

if [ -z "$ELASTICSEARCH_REPO_NAME" ]; then
  echo "You need to set the ELASTICSEARCH_REPO_NAME environment variable."
  exit 1
fi

if [ -z "$ELASTICSEARCH_HOST" ]; then
  echo "You need to set the ELASTICSEARCH_HOST environment variable."
  exit 1
fi

if [ -z "$S3_ENDPOINT" ]; then
  aws_args=""
else
  aws_args="--endpoint-url $S3_ENDPOINT"
fi

if [ -n "$S3_ACCESS_KEY_ID" ]; then
  export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY_ID
fi
if [ -n "$S3_SECRET_ACCESS_KEY" ]; then
  export AWS_SECRET_ACCESS_KEY=$S3_SECRET_ACCESS_KEY
fi
export AWS_DEFAULT_REGION=$S3_REGION
