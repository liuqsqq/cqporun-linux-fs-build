root_dir="/usr/local/resources/ads_resource"
killall -9 parole
date >> ads_log.txt
echo "ads is reboot" >> ads_log.txt
sleep 1
#parole -E  $root_dir/Ford_Focus_zhuizhu_30s_HD.mp4 $root_dir/暴风VR电视TVC30s.mp4 &
parole -E $root_dir/final_ads.mp4
killall -9 devilspie
devilspie&
