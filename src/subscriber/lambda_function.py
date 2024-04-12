import logging
import os
import boto3


DYNAMODB = boto3.client("dynamodb")
TABLE_NAME = os.environ["TARGET_TABLE"]

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def get_iot_messages(event):
    messages = {}
    for key in event:
        messages[key] = {"S": f"{event[key]}"}

    return messages


def write_iot_messages_to_dynamodb(messages, client):
    client.put_item(TableName=TABLE_NAME, Item=messages)


def lambda_handler(event, context):
    try:
        messages = get_iot_messages(event)
        write_iot_messages_to_dynamodb(messages, DYNAMODB)
        logger.info("Successfully writed messages to DynamoDB.")
    except Exception as e:
        logger.error("Failed to write messages to DynamoDB.")
        raise e
