#!/bin/bash 

ACTION=$1

keyword_keyboard="keyboard"
keyword_mouse="mouse" 

keyboard=$(cat /proc/bus/input/devices | grep -i $keyword_keyboard | awk -F '"'  '{print $2}' | tail -1 | awk '{print $1}')

if [ "$keyboard" != "" ];then
	if [ $ACTION = "on" ];then
		yinka-input $keyboard on
	elif [ $ACTION = "off" ];then
		yinka-input $keyboard off
	fi
    echo $keyboard
else
    echo "there is no keyboard"
fi

mouse=$(cat /proc/bus/input/devices | grep -i $keyword_mouse | awk -F '"'  '{print $2}' | tail -1 | awk '{print $3}')

if [ "$mouse" != "" ];then
	sleep 1
	if [ $ACTION = "on" ];then
		yinka-input $mouse on
	elif [ $ACTION = "off" ];then
		yinka-input $mouse off
	fi
    echo $mouse
else
    echo "there is no mouse"
fi

