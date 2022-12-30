#!/bin/bash

stat() {

echo "number of open sessions is : \e[41;32m $(who | wc -l) \e[0m"
echo "total number of users logged in is:$(uptime | awk -F, '{print $2}')"
echo "date is : $(date +%F)"

}

stat