#!/bin/bash -e

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

ifconfig wlan0 down
if ifconfig |grep enx0c5b8f279a64  >/dev/null ;then
    ifconfig enx0c5b8f279a64 down
fi
ifconfig wlan0 up
#service wicd restart
/etc/init.d/wicd restart
sleep 10
#try 10 times to connect wifi
cnt=0
while [ $cnt -le 10 ]
do
    ping -c2 www.yinka.co  > /dev/null 2>&1
    if [ $? -eq  0 ];then
       #echo "wlan0 connect successful!"
       break
    else
       cnt=$(($cnt+1))
    fi
done
if [ $cnt -gt 10 ];then
    echo "wifi is not alive, now change network to 4g "
    sh ./change_network_2_4g
else
    echo "wlan0 connect successfull!!"
fi
