# Introduction
This project provides Docker images to periodically back up a Elasticsearch to AWS S3, and to restore from the backup as needed.

# Usage
## Backup
```yaml
services:
  backup:
    image: vohoang/elasticsearch-backup-s3:latest
    environment:
      SCHEDULE: '@weekly'     # optional
      BACKUP_KEEP_DAYS: 7     # optional
      PASSPHRASE: passphrase  # optional
      S3_REGION: region
      S3_ACCESS_KEY_ID: key
      S3_SECRET_ACCESS_KEY: secret
      S3_BUCKET: my-bucket
      S3_PREFIX: backup
      ELASTICSEARCH_HOST: host:9200
      ELASTICSEARCH_USERNAME: user
      ELASTICSEARCH_PASSWORD: password
      ELASTICSEARCH_REPO_NAME: repo
      ELASTICSEARCH_INDEX_NAME: index-name
```

- The `SCHEDULE` variable determines backup frequency. See go-cron schedules documentation [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules). Omit to run the backup immediately and then exit.
- If `PASSPHRASE` is provided, the backup will be encrypted using GPG.
- Run `docker exec <container name> sh snapshot.sh` to trigger a snapshot ad-hoc.
- If `BACKUP_KEEP_DAYS` is set, backups older than this many days will be deleted from S3.
- Set `S3_ENDPOINT` if you're using a non-AWS S3-compatible storage provider.


