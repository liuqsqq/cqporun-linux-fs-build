#!/bin/bash
#try to reboot ads
while true
do
   ps -fe|grep parole |grep -v grep
   if [ $? -ne 0 ];then
       echo "try to reboot ads....."
       sh /usr/local/bin/scripts/restart_ads.sh
       sleep 2
   else
       echo "ads is already runing....."
       break
   fi
done
#monitor ads forever
while true
do
     while true
     do
         win_id=$(xwininfo -name "PRAdsPlayer" | grep "Window id" | grep -o '0x[0-f][0-f][0-f][0-f][0-f][0-f][0-f]')
         echo $win_id
	 if [ "$win_id" != "" ];then
             echo "get win_id, break"
             break
	 fi
	 done
     echo $win_id
     while true
     do
        import -frame -window  $win_id  ./first.jpg
	sleep 6 
        win_id=$(xwininfo -name "PRAdsPlayer" | grep "Window id" | grep -o '0x[0-f][0-f][0-f][0-f][0-f][0-f][0-f]')
	echo $win_id
	if [ "$win_id" == "" ];then
            sh /usr/local/bin/scripts/restart_ads.sh
            while true
            do
                echo "try to check whether PRAdsPlayer is exist"
                ps -fs | grep parole | grep -v grep
                if [ $? -ne 0 ];then
                    echo "try to reboot player......"
                    sh /usr/local/bin/scripts/restart_ads.sh
                else
                    echo "player is already running......"
                    break
                fi
                sleep 2
            done
	else
	    import -frame -window  $win_id ./second.jpg
        fi
	if [ $(md5sum first.jpg |cut -d ' ' -f1) ==  $(md5sum second.jpg |cut -d ' ' -f1) ];then
	    echo "same"
	    sh /usr/local/bin/scripts/restart_ads.sh
            while true
            do
	        echo "3s is over,try to check whether parole is exist "
		ps -fe|grep parole |grep -v grep
		if [ $? -ne 0 ];then
		   echo "try to reboot ads....."
	           sh /usr/local/bin/scripts/restart_ads.sh
		else
		   echo "ads is already runing....."
		   break
		fi
	        sleep 2
            done
            break
	    else
	       echo "diff"
	fi
    done
done


