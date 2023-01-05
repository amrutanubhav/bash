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

sudo rabbitmqctl add_user roboshop roboshop123

if [ $? -ne 0 ]; then
echo -n "create application user for $component: "
rabbitmqctl add_user roboshop roboshop123 &>> ${logfile}
stat $?

fi

echo -n "set permissions for application user: "
rabbitmqctl set_user_tags roboshop administrator &>> ${logfile}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> ${logfile}
stat $?

