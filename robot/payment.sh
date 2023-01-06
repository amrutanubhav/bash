#!/bin/bash
component=payment
source robot/common.sh

PYTHON


echo -n "change group id and user id for $component: "
user_id=$(id $user -u)
grp_id=$(id $user -g)

sed -i -e "/^uid/ c uid=${user_id}" /home/$user/$component/$component.ini
sed -i -e "/^gid/ c gid=${grp_id}" /home/$user/$component/$component.ini

stat $?

UPDATE_DNS


