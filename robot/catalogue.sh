#!/bin/bash

component=catalogue

source robot/common.sh

echo -n "Downloading $component setup: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${logfile}
stat $?

echo -n "Installing nodejs app: "
yum install nodejs -y &>> ${logfile}
stat $?

echo -n "Adding service account $user "
useradd $user
stat $?


# $ curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
# $ cd /home/roboshop
# $ unzip /tmp/catalogue.zip
# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install