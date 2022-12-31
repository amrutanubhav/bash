#!/bin/bash
echo "enter action"
read action
case $action in
     start)
        echo "we are starting"
        ;;
     restart)
        echo "we are restarting"
        ;;
     stop)
        echo "we are stopping"
        ;;
     *)
       echo " please enter valid option"
       ;;
esac  