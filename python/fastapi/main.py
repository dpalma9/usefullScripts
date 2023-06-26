from fastapi import FastAPI
from typing import Union
from pydantic import BaseModel
import logging

logger = logging.getLogger(__name__)

app = FastAPI()


class Item(BaseModel):
    name: str
    description: Union[str, None] = None

class Cluster(BaseModel):
    name: str

@app.get("/")
async def root():
    return {"message": "Wellcome to my FastAPI app"}

@app.get("/healthy")
async def root():
    return {"message": "API status is healthy"}

@app.get("/getendpoint")
async def get_endpoint():
    logger.info("/getendpoint endpoint request was received")
    return {"message": "GET received"}

#curl -X POST -H 'Content-Type: application/json' --data '{"name": "mycluster"}' localhost:8000/postendpoint
@app.post("/postendpoint")
async def post_endpoint(item: Item):
    logger.info("/postendpoint endpoint request was received")
    #item_dict = item.dict()
    if item.name:
        logger.info("Name: %s", item.name)
        return {"message": "Correct POST request."}
    else:
        logger.error("No name provided")
        return {"message": "Check POST parameters."}
    
@app.post("/cluster")
async def post_endpoint(cluster: Cluster):
    logger.info("/cluster endpoint request was received")
    if cluster.name:
        logger.info("Name: %s", cluster.name)
        return {"message": "Correct POST request."}
    else:
        logger.error("No name provided")
        return {"message": "Check POST parameters."}