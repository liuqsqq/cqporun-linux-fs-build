echo $2
if [ "$2" != "0" ];then
    echo "test"
    bluetooth_dir="/home/cqutprint/bluetooth_file"
    if [ ! -d $bluetooth_dir ];then
       mkdir $bluetooth_dir  
    fi
    if [ -f oldfiles.log ]
    then
        newfile=` ls -t $bluetooth_dir | head -1 `
        cat oldfiles.log | grep $newfile >/dev/null
        if [ $? -eq 1 ] 
        then
                echo "there is a new file: $newfile"
                echo $newfile >> oldfiles.log
        else
                echo "there is no new files"
        fi  

    else
        ls -t -r $bluetooth_dir  > oldfiles.log
        echo "cache old files info"
    fi
fi

if [ ! -n $newfile ];then
    python /usr/local/bin/scripts/monitor_bluetooth_event.py $1 $2 
else
    python /usr/local/bin/scripts/monitor_bluetooth_event.py $1 $2 $newfile

fi
