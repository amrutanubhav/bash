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
       echo -e " e\[32m please enter valid option e\[0m"
       ;;
esac  