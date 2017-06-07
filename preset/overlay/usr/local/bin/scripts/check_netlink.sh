#!/bin/sh
cnt=0
mobile_is_exist=0
while true
do
    Name=""
    mobile_is_exist=0
    if ifconfig -a  |grep enx0c5b8f279a64  >/dev/null ;then
        Name=enx0c5b8f279a64
    elif ifconfig -a  |grep usb0  >/dev/null ;then
        Name=usb0
    fi
    if [ "$Name" != "" ];then
        mobile_is_exist=1
    fi
    if [ $mobile_is_exist -eq 1 ];then
        echo "now is 4g network, need check"
        while true
        do
            ping -c2 www.yinka.co  > /dev/null 2>&1
            if [ $? -ne 0 ];then
                echo " disconnect from network "
                cnt=$(($cnt+1))
            else
                echo "4g connect"
                cnt=0
                break
            fi
            echo $cnt
            if [ $cnt -ge 10 ];then
                echo "network is  not alive, try to reset 4g network "
                echo "cqutprint" | sudo -S yinka-network 4g
                mobile_is_exist=0
                cnt=0
                break
            fi
            sleep 1
        done
    else
        echo "there is no 4g hardware"
    fi
    sleep 5
done