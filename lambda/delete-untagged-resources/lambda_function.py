import boto3
import json
import logging

logging.basicConfig()
logging.getLogger().setLevel(level=logging.INFO)


def lambda_handler(event, context):
    for region in [ "us-east-1", "us-east-2", "us-west-1", "us-west-2"]:
        processEC2(region)
    
def processEC2(region):
    logging.info(f'processing EC2 region {region}')
    client = boto3.client('ec2', region_name=region)
    for instance in describeInstances(client):
        logging.info(f'examining {json.dumps(instance)}')
        
def describeInstances(client):
    result = []
    paginator = client.get_paginator('describe_instances')
    for page in paginator.paginate():
        for reservation in page['Reservations']:
            for instance in reservation['Instances']:
                result.append(extractInstanceDetails(instance))
    return result
    
def extractInstanceDetails(instance):
    logging.debug(f"extracting details from instance {instance['InstanceId']}")
    return {
        'InstanceId': instance['InstanceId']
    }

