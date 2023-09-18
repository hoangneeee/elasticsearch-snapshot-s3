ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}
ARG TARGETARCH

ADD src/install.sh install.sh
RUN sh install.sh && rm install.sh

ENV ELASTICSEARCH_HOST ''
ENV ELASTICSEARCH_USERNAME ''
ENV ELASTICSEARCH_PASSWORD ''
ENV ELASTICSEARCH_REPO_NAME ''
ENV ELASTICSEARCH_INDEX_NAME ''
ENV S3_ACCESS_KEY_ID ''
ENV S3_SECRET_ACCESS_KEY ''
ENV S3_BUCKET ''
ENV S3_REGION 'us-west-1'
ENV S3_PREFIX 'backup'
ENV S3_ENDPOINT ''
ENV S3_S3V4 'no'
ENV SCHEDULE ''
ENV PASSPHRASE ''
ENV BACKUP_KEEP_DAYS ''

ADD src/run.sh run.sh
ADD src/env.sh env.sh
ADD src/repository.sh repository.sh
ADD src/snapshot.sh snapshot.sh
ADD src/reloadable-secure-settings.sh reloadable-secure-settings.sh

CMD ["sh", "run.sh"]
