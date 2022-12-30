#!/bin/bash

stat() {

echo "number of open sessions is : $(who | ec -l)"
echo "total number of users logged in is:$(uptime)"
echo "date is : $(date +%F)"

}

stat