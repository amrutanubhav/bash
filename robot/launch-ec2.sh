#!/bin/bash

component=$1
ami_id=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" --region us-east-1 | jq .Images[].ImageId | sed -e 's/"//g')
sec_grp_id=$(aws ec2 describe-security-groups --filters Name=group-name,Values=Batch52-securitygroup --region us-east-1 | jq .SecurityGroups[].GroupId | sed -e 's/"//g')
Hosted_zid="Z02177131QU6HVDVL4864"


echo "Fetching ami id : $ami_id"
echo "Fetching sec grp id:  $sec_grp_id "

echo "launch instance using ami id and sec grp id "

Priv_IP=$(aws ec2 run-instances --image-id ${ami_id} --instance-type t3.micro --security-group-ids ${sec_grp_id} --tag-specification "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')

echo "Please find the Private Ip address for the $component : $Priv_IP"

sed -e 's/component/$component' -e 's/ipaddress/$Priv_IP' /home/centos/bash/robot/route53.json > /tmp/r53.json

echo "Allocating DNS record for the $component "

aws route53 change-resource-record-sets --hosted-zone-id $Hosted_zid --change-batch file:///tmp/r53.json