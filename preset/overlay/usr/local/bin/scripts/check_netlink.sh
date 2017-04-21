#!/bin/sh
cnt=0
wlan_is_exist=0
mobile_is_exist=0
while true
do
    if ifconfig |grep enx0c5b8f279a64  >/dev/null ;then
        mobile_is_exist=1
        wlan_is_exist=0
    else
        mobile_is_exist=0
        if ifconfig |grep wlan0 >/dev/null ;then
            wlan_is_exist=1
        else
            wlan_is_exist=0
            echo "try to restart wifi(wicd)!"
            echo "cqutprint" | sudo -S /usr/local/bin/scripts/change_network_2_wifi.sh
            mobile_is_exist=0
        fi
    fi
    if [ $wlan_is_exist -eq 1 ];then
        echo "now is wifi network, need check"
        while true
        do
            ping -c2 www.yinka.co  > /dev/null 2>&1
            if [ $? -ne 0 ];then
                echo "wlan0 disconnect from network "
                cnt=$(($cnt+1))
            else
                echo "wlan0 connect"
                cnt=0
                break
            fi
            echo $cnt
            if [ $cnt -ge 20 ];then
                echo "wlan0 is not alive, try to change to 4g network "
                echo "cqutprint" | sudo -S /usr/local/bin/scripts/change_network_2_4g.sh
                wlan_is_exist=0
                cnt=0
                break
            fi
            sleep 1
        done
    fi
    if [ $mobile_is_exist -eq 1 ];then
    #check 4g network, now do nothing, to be continue
        echo "now is 4g network, need't check"
    fi
    sleep 10
done
