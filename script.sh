#!/usr/bin/bash

#read setting file
sed -z s/.*#lets_encrypt//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >setting_lets_encrypt.log

#lets_encrypt setting
echo "" > wait_script.sh
chmod 777 wait_script.sh
cat setting_lets_encrypt.log |awk -F ":" -f script.awk

#run container
echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
	./wait_script.sh

	#cleaning
	wait
	docker rm certbot -f
	docker rmi certbot
	echo "log file is /var/log/docker_log"
fi

rm *.log wait_script.sh
echo "ok!!"
