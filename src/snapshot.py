import json

import requests

from config import *


class ElasticsearchSnapshot:
    def __init__(self):
        self.create_repo()

    def create_repo(self):
        repo_body = {
            'type': 's3',
            'settings': {
                'bucket': s3_bucket,
                'base_path': s3_prefix,
            }
        }

        print(f'Creating repository {es_repo_name} on {es_host}...')
        try:
            r = requests.put(
                f'{es_host}/_snapshot/{es_repo_name}?pretty',
                auth=(es_username, es_password),
                data=json.dumps(repo_body),
                headers=headers)
            print(r.text)
            print('Creating repository successfully')
        except Exception as e:
            print(e)

    def automated_snapshot(self):
        print(f'Creating automate snapshot of {es_index_name} indexes...')
        body = {
            "schedule": schedule,
            "name": '<%s-{now/d}>' % es_repo_name,
            "repository": f"{es_repo_name}",
            "config": {
                "indices": [es_index_name],
                "ignore_unavailable": False,
                "include_global_state": False
            },
            "retention": {
                "expire_after": f'{backup_keep_days}d',
                "min_count": 5,
                "max_count": 30
            }
        }

        try:
            r = requests.put(
                f'{es_host}/_slm/policy/policy-{es_repo_name}?pretty',
                auth=(es_username, es_password),
                data=json.dumps(body),
                headers=headers)
            print(r.text)
            print('Automate snapshot created')
        except Exception as e:
            print(e)

    def snapshot(self):
        print(f'Creating snapshot of {es_index_name} indexes...')
        body = {
            "indies": f"{es_index_name}",
            "ignore_unavailable": True,
            "include_global_state": False,
            "metadata": {
                "taken_by": f"{es_username}",
                "taken_because": "snapshot manual"
            }
        }

        try:
            r = requests.put(
                f'{es_host}/_snapshot/{es_repo_name}/{es_repo_name}-{current_format_date()}?wait_for_completion=true',
                auth=(es_username, es_password),
                data=json.dumps(body),
                headers=headers)
            print(r.text)
            print('Snapshot created')
        except Exception as e:
            print(e)
