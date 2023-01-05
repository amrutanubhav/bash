#!/bin/bash
component=rabbitmq
source robot/common.sh

echo -n "Install erlang dependancy for $component: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>> ${logfile}
stat $?

echo -n "Setup YUM repositories for $component: "
curl -s https://packagecloud.io/install/repositories/$component/$component-server/script.rpm.sh | sudo bash &>> ${logfile}
stat $?

echo -n "install $component: "
yum install $component-server -y &>> ${logfile}
stat $?

echo -n "enable and start $component: "
systemctl enable rabbitmq-server &>> ${logfile}
systemctl start rabbitmq-server &>> ${logfile}
systemctl status rabbitmq-server -l &>> ${logfile}
stat $?

echo -n "create application use for $component: "

rabbitmqctl add_user roboshop roboshop123  
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

stat $?

