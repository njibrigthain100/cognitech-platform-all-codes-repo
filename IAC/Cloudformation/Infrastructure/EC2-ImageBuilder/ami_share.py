#!/usr/bin/env python
import boto3
import json

def lambda_handler(event, context):
    # Replace with your own values
    secret_name = 'BK-PROD-us-east-1-Daily-AMI'
    organization_id = 'o-orvtyisdyc'

    # Initialize AWS clients
    secrets_manager = boto3.client('secretsmanager')
    ec2_client = boto3.client('ec2')

    try:
        # Retrieve the AMI ID from Secrets Manager
        secret_response = secrets_manager.get_secret_value(SecretId=secret_name)
        secret_data = json.loads(secret_response['SecretString'])
        ami_id = secret_data.get('ami_id')

        if not ami_id:
            return {
                'statusCode': 400,
                'body': 'AMI ID not found in secret'
            }

        # Update the tag of the AMI
        ec2_client.create_tags(Resources=[ami_id], Tags=[{'Key': 'ami_status', 'Value': 'approved'}])

        # Share the AMI with the organization
        ec2_client.modify_image_attribute(ImageId=ami_id, LaunchPermission={'Add': [{'Group': 'all'}]})

        return {
            'statusCode': 200,
            'body': 'AMI tag updated to "approved" and shared with the organization'
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }

