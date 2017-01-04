#!/bin/bash
keyword="yinka-4.1.20-linux-armv7l"
while true
do
    ps -fe|grep $keyword |grep -v grep > /dev/null 2>&1
    if [ $? -ne 0 ] ;then
        echo "yinka terminal is not running, try to reboot....."
	    sh /usr/local/bin/scripts/restart_yinka_terminal.sh
    else
        echo "yinka terminal is already runing....."
    fi
	sleep 5
done
