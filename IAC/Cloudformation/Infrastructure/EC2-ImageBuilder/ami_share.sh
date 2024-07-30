#!/bin/bash

# Replace with your own values
PARAMETER_NAME="/standard/Ami/Daily"

# Retrieve the latest AMI ID from Parameter store
echo "==============================================="
echo "Retrieving AMI from the parameter store"
echo "==============================================="
ami_id=$(aws ssm get-parameter --name " /standard/Ami/Daily" --query "Parameter.Value" --output text)
# $(aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" --query "SecretString | fromjson.ami_id" --output text)

if [[ -z "$ami_id" ]]; then
    echo "AMI ID not found in Parameter store."
    exit 1
fi
echo "==============================================="
echo "AMI retrived"
echo "==============================================="
echo "==============================================="
echo "Updating AMI tag to approved"
echo "==============================================="
# Update the tag of the AMI
aws ec2 create-tags --resources "$ami_id" --tags Key=ami_status,Value=approved
echo "==============================================="
echo "AMI tag updated"
echo "==============================================="
echo "==============================================="
echo "Sharing AMI to organization"
echo "==============================================="
# Share the AMI with the organization
 aws ec2 modify-image-attribute --image-id "$ami_id" --launch-permission "Add=[{OrganizationArn=arn:aws:organizations::485147667400:organization/o-orvtyisdyc}]"
# aws ec2 modify-image-attribute --image-id "$ami_id" --launch-permission "{\"Add\":[{\"Group\":\"all\"}]}"
echo "================================================"
echo "AMI succesfully shared to the orgnization"
echo "================================================"
echo "===================================================="
echo "AMI retrived, tagged and shared for us-east-1"
echo "===================================================="
echo "===================================================="
echo "Starting AMI copy to us-west-2"
echo "===================================================="
# Copy the AMI to us-west-2
 aws ec2 copy-image --region us-west-2 --name amazonlinux2-golden-AMI --source-region us-east-1 --source-image-id "$ami_id" --encrypted --kms-key-id alias/ImagebuilderKey
echo "===================================================="
echo "AMI succesfully copied to us-west-2"
echo "===================================================="
echo "===================================================="
echo "Storing AMI to parameter store"
echo "===================================================="
# Update value in us-west-2 parameter store
 aws ec2 describe-images --owners self --query 'reverse(sort_by(Images,&CreationDate))[0].ImageId' --output text --region us-west-2 | aws ssm put-parameter --name " /standard/Ami/Daily" --value "$(cat -)" --type "String" --overwrite --region us-west-2 
echo "===================================================="
echo "AMI succesfully stored in parameter store"
echo "===================================================="
# Wait for AMI to become available 
 sleep 2m
echo "===================================================="
echo "Waiting for AMI to become available"
echo "===================================================="
# Retrieve the latest AMI ID from Parameter store
ami_id_us_west_2=$(aws ssm get-parameter --name " /standard/Ami/Daily" --query "Parameter.Value" --output text --region us-west-2)
echo "===================================================="
echo "Retrieving AMI from the parameter store"
echo "===================================================="
echo "===================================================="
echo "Sharing AMI to organization"
echo "===================================================="
# Share the AMI with the organization
 aws --region us-west-2 ec2 modify-image-attribute --image-id "$ami_id_us_west_2" --launch-permission "Add=[{OrganizationArn=arn:aws:organizations::485147667400:organization/o-orvtyisdyc}]"
 echo "==================================================="
  echo "AMI succesfully shared to the orgnization"
 echo "==================================================="