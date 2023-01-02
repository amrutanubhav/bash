#!/bin/bash

component=redis

source robot/common.sh

echo -n "downloading $component repository: "
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?

echo -n "Installing $component : "
yum install redis-6.2.7 -y &>> ${logfile}
stat $?

echo -n "update BindIP of $component: "
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/$component.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$component/$component.conf
stat $?

echo -n "enable and restart $component: "
systemctl daemon-reload
systemctl enable redis
systemctl restart redis
stat $?