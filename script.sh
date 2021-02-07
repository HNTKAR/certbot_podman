#!/bin/bash

cd $(dirname $0)

#read setting file
sed -z -e "s/.*##\+ssl#*//g" \
	-e "s/##.\+//g" setting.txt >setting.log

#build image
read -p "do you want to build this image ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	podman rmi -f certbot
	podman build -f Dockerfile -t certbot:latest
fi

rm *.log
