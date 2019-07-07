#!/usr/bin/bash
firewall-cmd --add-service=http
read -p "set your server FQDN :" fqdn
read -p "set your mail address :" mail
cat myapp.sh.default | sed -e  s/server_name/$fqdn/g > tmp
cat tmp | sed -e  s/admin-mail/$mail/g > myapp.sh
rm tmp
docker-compose up --build -d
sleep 10
docker rm certbot -f
docker rmi certbot
firewall-cmd --reload
