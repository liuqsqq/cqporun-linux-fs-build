root_dir="/usr/local/yinka_terminal/yinka-4.1.20-linux-armv7l"

killall -9 yinka
sleep 1
echo $root_dir
$root_dir/yinka --use-gl=egl &
#killall -9 devilspie
#devilspie&
