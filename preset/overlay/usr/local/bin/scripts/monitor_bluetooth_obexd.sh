bluetooth_dir="/home/cqutprint/bluetooth_file"
if [ ! -d $bluetooth_dir ];then
    mkdir $bluetooth_dir 
fi
killall obexd
export DISPLAY=:0.0
expect<<EOF
set timeout -1
spawn /usr/lib/bluetooth/obexd -d -r /home/cqutprint/bluetooth_file -n -a
while {1} {
    expect "CONNECT(0x0), (null)(0xffffffff)"
    puts "transfer start"
    exec sh -c {/usr/local/bin/scripts/monitor_bluetooth_event.sh 3 0} 
    expect "DISCONNECT(0x1), SUCCESS(0x20)"
    exec sh -c {/usr/local/bin/scripts/monitor_bluetooth_event.sh 3 1} 
    puts  "transfer complete"
}
EOF
echo "error,obexd service is quit"

