#!/bin/bash

stat() {

echo "number of open sessions is : $(who | wc -l)"
echo "total number of users logged in is:$(uptime | awk -F , '{print $2}')"
echo "date is : $(date +%F)"

}

stat