#!/bin/bash

stat() {

echo "number of open sessions is : $(\e[41;32m $(who | wc -l) \e[0m)"
echo "total number of users loggedin is: $(uptime | awk -F, '{print $2}')"
echo "date is : $(date +%F)"

}

stat


# dajdandnakd asamdasn adsasm
# skdbakadsj
# ksjndal