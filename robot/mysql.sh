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

echo show databases | mysql -uroot -pRoboShop@1 &>> ${logfile}

if [ $? -ne 0 ]; then

echo -n "change default password for $component: "
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';"| mysql --connect-expired-password -uroot -p${DEF_PASS} &>> ${logfile}
stat $?

fi

echo show plugins | mysql -uroot -pRoboShop@1 | grep validate_password; &>> &{logfile}
if [ $? -eq 0 ]

echo -n "uninstalling Validate password plugin from $component: "
echo 'uninstall plugin validate_password;' | mysql -uroot -pRoboShop@1 &>> ${logfile}
stat $?

fi

echo -n "downloading schema for $component: "
curl -s -L -o /tmp/$component.zip "https://github.com/stans-robot-project/$component/archive/main.zip"
stat $?

echo -n "Unzip and inject schema to $component: "

cd /tmp
unzip mysql.zip
cd mysql-main
mysql -u root -pRoboShop@1 <shipping.sql

stat $?

