#!/bin/bash

component=user

source robot/common.sh

NODE_JS

# echo -n "Downloading $component setup: "
# curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${logfile}
# stat $?

# echo -n "Installing nodejs app: "
# yum install nodejs -y &>> ${logfile}
# stat $?


# id $user &>> ${logfile}

# if [ $? -ne 0 ]; then

# echo -n "Adding service account $user "
# useradd $user &>> ${logfile}
# stat $?

# fi

# echo -n "downloading the $component"
# curl -s -L -o /tmp/$component.zip "https://github.com/stans-robot-project/$component/archive/main.zip" &>> ${logfile}
# stat $?

# echo -n "cleanup and Extracting $component: "
# rm -rf /home/$user/$component
# cd /home/$user
# unzip -o /tmp/$component.zip &>> ${logfile}
# stat $?

# echo -n "Changing the ownership to $user: "
# mv /home/$user/$component-main $component
# chown -R $user:$user /home/$user/$component
# stat $?

# echo -n "Generate artifacts for $component: "
# cd /home/$user/$component/
# npm install &>> ${logfile}
# stat $?

# echo -n "update systemd service for $component: "
# sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/$user/$component/systemd.service
# sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/$user/$component/systemd.service
# mv /home/$user/$component/systemd.service /etc/systemd/system/$component.service
# stat $?

# echo -n "enable and restart $component: "
# systemctl daemon-reload &>> ${logfile} 
# systemctl enable $component.service &>> ${logfile}
# systemctl restart $component.service -l &>> ${logfile}
# stat $?