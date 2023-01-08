#!/bin/bash

component=$1
ami_id=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g')
sec_grp_id=$(aws ec2 describe-security-groups --filters Name=group-name,Values=Batch52-securitygroup --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g')
Hosted_zid="Z02177131QU6HVDVL4864"


echo "Fetching ami id : $ami_id"
echo "Fetching sec grp id:  $sec_grp_id "

echo "launch instance using ami id and sec grp id "

private_ip=$(aws ec2 run-instances --image-id ${ami_id} --instance-type t3.micro --security-group-ids ${sec_grp_id} --tag-specification "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]" | jq '.Instances[].PrivateIpAddress')