#!/bin/bash
#code to display hello world
#escape sequence
#newline \n
#tabspace \t
# -e is to enable escape sequen
####################################################

#color coding for bash syntax \e[codem....\e[0m]
echo -e "\e[32m i am printing green colour \e[0m"
echo -e "\e[31m i am printing red colour \e[0m"
echo -e "\e[33m i am printing yellow colour \e[0m"
echo -e "\e[34m i am printing blue colour \e[0m"

#print background color "\e[41;33m ..... [0m"
echo -e "\e[41;33m this is test for background color [0m"