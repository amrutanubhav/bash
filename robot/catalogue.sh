#!/bin/bash

component=catalogue

source robot/common.sh

echo -n "Downloading $component setup: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${logfile}
stat $?

echo -n "Installing nodejs app: "
yum install nodejs -y &>> ${logfile}
stat $?


id $user &>> ${logfile}

if [ $? -ne 0 ]; then

echo -n "Adding service account $user "
useradd $user &>> ${logfile}
stat $?

fi

echo -n "downloading the $component"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip" &>> ${logfile}
stat $?

echo -n "cleanup and Extracting $component: "
rm -rf /home/$user/$component
cd /home/$user
unzip -o /tmp/$component.zip &>> ${logfile}
stat $?

echo -n "Changing the ownership to $user: "
mv /home/$user/$component-main $component
chown -R $user:$user /home/$user/$component
stat $?

echo -n "Generate artifacts for $component: "
cd /home/$user/$component/
npm install &>> ${logfile}
stat $?
