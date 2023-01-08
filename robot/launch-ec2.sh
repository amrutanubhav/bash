#!/bin/bash

component=$1
ami_id=${aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g'}
sec_grp_id=${aws ec2 describe-security-groups --filters Name=group-name,Values=Batch52-securitygroup --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g'}

echo "Fetching ami id : e\[31m ${ami_id} e\[0m"
echo "Fetching sec grp id: e\[31m ${sec_grp_id} e\[0m"

echo "launch instance using ami id and sec grp id "

aws ec2 run-instances --image-id ${ami_id} --instance-type t3.micro --security-group-ids ${sec_grp_id} --tags Key=Name,Value=${component} --tag-specification 'ResourceType=instance,Tags=[{Key=name,Value=$component}' | jq