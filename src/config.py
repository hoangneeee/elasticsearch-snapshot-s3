import os
from datetime import datetime


def current_format_date(format="%Y-%m-%d") -> str:
    current_datetime = datetime.now()
    return current_datetime.strftime(format)


headers = {
    "Content-Type": "application/json"
}

schedule = os.environ['SCHEDULE']  # optional
backup_keep_days = os.environ['BACKUP_KEEP_DAYS']  # optional
passphrase = os.environ['PASSPHRASE']  # optional

s3_region = os.environ['S3_REGION']
s3_access_key_id = os.environ['S3_ACCESS_KEY_ID']
s3_secret_access_key = os.environ['S3_SECRET_ACCESS_KEY']
s3_bucket = os.environ['S3_BUCKET']
s3_prefix = os.environ['S3_PREFIX']

es_host = os.environ['ELASTICSEARCH_HOST']
es_username = os.environ['ELASTICSEARCH_USERNAME']
es_password = os.environ['ELASTICSEARCH_PASSWORD']
es_repo_name = os.environ['ELASTICSEARCH_REPO_NAME']
es_index_name = os.environ['ELASTICSEARCH_INDEX_NAME']
