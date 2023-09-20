from fastapi import FastAPI

from main import *

app = FastAPI(
    title="Elasticsearch snapshot to s3",
    description="A handy Docker container to periodically snapshot Elasticsearch to S3",
)

esm = ElasticsearchSnapshot()


@app.get("/", summary="Health check")
def health_check():
    return {"status": "green"}


@app.get("/snapshot", summary="Create snapshot")
def create_snapshot():
    esm.snapshot()
    return {"success": True}
