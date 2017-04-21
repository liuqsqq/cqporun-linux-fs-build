if [ "$1" = "pair" ];then
   (sleep 3
    yes) | btmgmt pair $2 > /home/cqutprint/bluelog.txt 2>&1  
   if cat /home/cqutprint/bluelog.txt | tail -2  | grep failed;then
       python /usr/local/bin/scripts/monitor_bluetooth_event.py 2 0    
   else
       python /usr/local/bin/scripts/monitor_bluetooth_event.py 2 1    
   fi

elif [ "$1" = "unpair" ];then
    btmgmt unpair $2
fi


