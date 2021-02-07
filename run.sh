#!/usr/bin/bash
mkdir -pm 644 /log
date > /log/certbot.log
sed -e "s/^domain://g" /usr/local/bin/setting.log | \
	xargs -I {} sh -c \
	'certbot certonly --standalone --dry-run --expand --register-unsafely-without-email --agree-tos -d {} >> /log/certbot.log'
resp=a$(grep "error" /log/certbot.log)
if [ $resp = "a" ]; then
	rm -rf /etc/letsencrypt/*
	echo -e "OK!!\n" >> /log/certbot.log
	sed -e "s/^domain://g" /usr/local/bin/setting.log | \
	xargs -I {} sh -c \
	'certbot certonly --standalone --keep --expand --register-unsafely-without-email --agree-tos -d {} >> /log/certbot.log'
else
	echo -e "ERROR!!\n" >> /log/certbot.log
	echo -e "resp:\n$resp\n"  >> /log/certbot.log
fi
echo -e "END"  >> /log/certbot.log
