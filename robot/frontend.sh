#!/bin/bash
set -e
component=frontend

source robot/common.sh

echo -n "Installing NGINX: "
yum install nginx -y    &>> $logfile


echo -n "Starting NGINX: "
systemctl enable nginx  &>> $logfile
systemctl start nginx   &>> $logfile
stat $?

echo -n "Downloading frontend file : "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $logfile
stat $?

echo -n "Clearing default content: "
cd /usr/share/nginx/html &>> $logfile
rm -rf *
stat $?

echo -n "Extracting $component: "
unzip /tmp/$component.zip &>> $logfile
stat $?

echo -n "Copying $component"
mv frontend-main/* . &>> $logfile
mv static/* . &>> $logfile
rm -rf frontend-main README.md &>> $logfile
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $logfile
stat $?
