#!/usr/bin/bash
echo "$(date)">>/var/log/letsencrypt/run.log
echo "\$FLAG   = $FLAG">>/var/log/letsencrypt/run.log
echo "">>/var/log/letsencrypt/run.log

exec certbot renew $FLAG
