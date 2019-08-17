import boto3
import json
import logging

logging.basicConfig()
logging.getLogger().setLevel(level=logging.INFO)


def lambda_handler(event, context):
    for region in [ "us-east-1", "us-east-2", "us-west-1", "us-west-2"]:
        process_ec2(region)

def process_ec2(region):
    logging.info(f'processing EC2 region {region}')
    ec2 = boto3.resource('ec2', region_name=region)
    for instance in ec2.instances.all():
        logging.debug(f'examining {instance.id}')
        if has_no_name(instance):
            logging.info(f'terminating {instance.id} because it has no name')
            # instance.terminate()

def has_no_name(instance):
    if not instance.tags:
        return True
    for tag in instance.tags:
        if tag['Key'] == 'Name':
            return False
    return True
