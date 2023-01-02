#!/bin/bash
component=mongodb

source robot/common.sh

echo -n " Downloading $component repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo &>> ${logfile}
stat $?

echo -n " Installing $component repo"
yum install -y mongodb-org &>> ${logfile}
stat $?

echo -n "allow to external for $component"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Enable and start $component"
systemctl daemon-reload
systemctl enable mongod &>> ${logfile}
systemctl start mongod &>> ${logfile}
stat $?

echo -n "Downloading the $component schema: "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip" &>> ${logfile}
stat $?

echo -n "Extracting the $component schema file"
 cd /tmp
 unzip -o mongodb.zip &>> ${logfile}
 stat $?


 echo -n "Injecting the schema : "
 cd mongodb-main 
 mongo < catalogue.js &>> ${logfile}
 mongo < users.js &>> ${logfile}
 stat $?
