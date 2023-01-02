#!/bin/bash
component=mysql

source robot/common.sh

echo -n " Setup $component repository:  "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo &>> ${logfile}
stat $?

echo -n "Install $component : "
yum install mysql-community-server -y &>> ${logfile}
stat $?

echo -n "Enable and restart $component : "
systemctl enable mysqld 
systemctl start mysqld
stat $?

