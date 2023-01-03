logfile=/tmp/$component.log
user=roboshop

ID=$(id -u)
if [ $ID -ne 0 ]; then

echo -e "\e[31m Please use root account or sudo privilege to proceed further \e[0m"
exit 1

fi


stat() {

if [ $1 -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

}

NODE_JS() {

echo -n "Downloading $component setup: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> ${logfile}
stat $?

echo -n "Installing nodejs app: "
yum install nodejs -y &>> ${logfile}
stat $?

ADD_VALIDATE_USER

DOWNLOAD_COMPONENT

UPDATE_DNS

}

ADD_VALIDATE_USER() {

id $user &>> ${logfile}

if [ $? -ne 0 ]; then

echo -n "Adding service account $user "
useradd $user &>> ${logfile}
stat $?

fi

}

DOWNLOAD_COMPONENT() {

echo -n "downloading the $component"
curl -s -L -o /tmp/$component.zip "https://github.com/stans-robot-project/$component/archive/main.zip" &>> ${logfile}
stat $?

CLEAN_EXTRACT_CHOWN

}

CLEAN_EXTRACT_CHOWN() {

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

}

UPDATE_DNS() {

echo -n "update systemd service for $component: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/$user/$component/systemd.service
mv /home/$user/$component/systemd.service /etc/systemd/system/$component.service
stat $?

ENABLE_RESTART

}

ENABLE_RESTART() {

echo -n "enable and restart $component: "
systemctl daemon-reload &>> ${logfile} 
systemctl enable $component.service &>> ${logfile}
systemctl restart $component.service -l &>> ${logfile}
stat $?

}