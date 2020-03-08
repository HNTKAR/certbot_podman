#!/usr/bin/bash

#read setting file
sed -e "s/^##.*//g"  setting.txt |\
	sed -ze "s/.*=====lets_encrypt=====//g" \
	-e  "s/=====.*//g" |\
	sed -ze "s/.*-----system data-----//g" \
	-e "s/-----.*//g" |\
	sed -e /^$/d>lets_encrypt-system.log

sed -e "s/^##.*//g"  setting.txt |\
	sed -ze "s/.*=====lets_encrypt=====//g" \
	-e  "s/=====.*//g" |\
	sed -ze "s/.*-----user data-----//g" \
	-e "s/-----.*//g" |\
	sed -e /^$/d>lets_encrypt-user.log

#lets_encrypt setting
echo "" > wait_script.sh
chmod 777 wait_script.sh
cat lets_encrypt-system.log |awk -F ":" -f script.awk

#run container
echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
	echo "log file is /var/log/docker_log"
fi

rm *.log wait_script.sh
echo "ok!!"
