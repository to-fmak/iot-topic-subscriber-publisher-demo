import logging
import json
import os

import boto3


IOT = boto3.client("iot-data")
TOPIC = os.environ["TOPIC"]

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def create_data(records):
    data = {}
    for record in records["Records"]:
        if record["eventName"] == "INSERT":
            data["eventName"] = "INSERT"
            data["NewImage"] = record["dynamodb"]["NewImage"]
        elif record["eventName"] == "MODIFY":
            data["eventName"] = "MODIFY"
            data["OldImage"] = record["dynamodb"]["OldImage"]
            data["NewImage"] = record["dynamodb"]["NewImage"]
        elif record["eventName"] == "REMOVE":
            data["eventName"] = "REMOVE"
            data["OldImage"] = record["dynamodb"]["OldImage"]

    return data


def publish_message(data, client):
    client.publish(
        topic=TOPIC,
        qos=1,
        payload=json.dumps(data, ensure_ascii=False)
    )


def lambda_handler(event, context):
    try:
        data = create_data(event)
        publish_message(data, IOT)
    except Exception as e:
        logger.error("Faild to send messages to Iot client.")
        raise e
