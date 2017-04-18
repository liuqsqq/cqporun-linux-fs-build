#!/bin/bash
#try to reboot ads
while true
do
   ps -fe|grep parole |grep -v grep
   if [ $? -ne 0 ];then
       echo "try to reboot ads....."
	   pkill -f yinka-player
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
         win_id=$(xwininfo -name "yinka-player" | grep "Window id" | grep -o '0x[0-f][0-f][0-f][0-f][0-f][0-f][0-f]')
         echo $win_id
	 if [ "$win_id" != "" ];then
             echo "get win_id, break"
             break
	 fi
	 done
     echo $win_id
     while true
     do
        import -frame -window  $win_id  /var/tmp/yinka/player/first.jpg
	sleep 6 
        win_id=$(xwininfo -name "yinka-player" | grep "Window id" | grep -o '0x[0-f][0-f][0-f][0-f][0-f][0-f][0-f]')
	echo $win_id
	if [ "$win_id" == "" ];then
            pkill -f yinka-player
	else
	    import -frame -window  $win_id /var/tmp/yinka/player/second.jpg
        fi
	if [ $(md5sum /var/tmp/yinka/player/first.jpg |cut -d ' ' -f1) ==  $(md5sum /var/tmp/yinka/player/second.jpg |cut -d ' ' -f1) ];then
	    echo "same"
	    pkill -f yinka-player
	else
	    echo "diff"
	fi
    done
done


