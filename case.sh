#!/bin/bash
echo "enter action"
read action
case $action in
     start)
        echo "we are starting"
        exit 0
        ;;
     restart)
        echo "we are restarting"
        exit 0
        ;;
     stop)
        echo "we are stopping"
        exit 0
        ;;
     *)
       echo -e "\e[32m please enter valid option \e[0m"
       exit 1
       ;;
esac  