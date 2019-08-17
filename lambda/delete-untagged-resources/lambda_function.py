import boto3
import json
import logging
from datetime import *

LAUNCH_TIME_THRESHOLD = datetime.now(timezone.utc) - timedelta(days=7)

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
        elif too_old(instance):
            logging.info(f'terminating {instance.id} because it has been running too long')
            # instance.terminate()

def has_no_name(instance):
    return not find_tag(instance.tags, 'Name')

def too_old(instance):
    if instance.launch_time > LAUNCH_TIME_THRESHOLD:
        return False
    deleteAfter = find_tag(instance.tags, 'DeleteAfter')
    if deleteAfter and date.today().isoformat() < deleteAfter:
        return False
    logging.debug(f'too_old(): launch time = {instance.launch_time}, deleteAfter = {deleteAfter}')
    return True

def find_tag(tags, key):
    if tags:
        for tag in tags:
            if tag['Key'] == key:
                return tag['Value']
    return None
