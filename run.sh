#!/usr/bin/bash
echo "$(date)">>/var/log/letsencrypt/run.log
echo "\$FLAG   = $FLAG">>/var/log/letsencrypt/run.log
echo "\$MAIL   = $MAIL">>/var/log/letsencrypt/run.log
echo "\$DOMAIN = -d $DOMAIN">>/var/log/letsencrypt/run.log
echo "">>/var/log/letsencrypt/run.log

exec certbot certonly \
	--dns-google \
	--dns-google-credentials /key.json \
	--agree-tos \
	$FLAG \
	$MAIL \
	-d $DOMAIN \
	
