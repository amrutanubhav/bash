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

echo -n "Fetch default password for $component: "
DEF_PASS=$(sudo cat /var/log/mysqld.log | grep 'A temporary password' | awk '{print $NF}')
stat $?

echo -n "change default password for $component: "
echo 'ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';' | mysql -uroot --connect-expired-password -p${DEF_PASS} &>> ${logfile}
stat $?