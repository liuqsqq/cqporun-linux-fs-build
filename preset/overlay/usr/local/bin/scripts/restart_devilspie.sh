
devil_id=$(ps -ef | grep 'devilspie'  | grep -v grep |  awk '{print $2}')
echo $devil_id
if [ "$devil_id" != "" ];then
   kill $devil_id
else
   echo "not exist devilspie"
fi
echo "start to reboot devilspie"
devilspie&
