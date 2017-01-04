#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
if ifconfig |grep enx0c5b8f279a64  >/dev/null ;then
    ifconfig enx0c5b8f279a64 down
fi

if ifconfig |grep wlan0  >/dev/null ;then
    ifconfig wlan0 down
fi
/etc/init.d/wicd stop
ifconfig enx0c5b8f279a64 up
dhclient enx0c5b8f279a64


