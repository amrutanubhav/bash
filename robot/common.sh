logfile=/tmp/$component.log

ID=$(id -u)
if [ $ID -ne 0 ]; then

echo -e "\e[31m Please use root account or sudo privilege to proceed further \e[0m"
exit 1

fi


stat(){

if [ $1 -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

}

