#!/usr/bin/bash
date >> /var/log/docker_log/certbot_log
/usr/local/bin/certbot-auto certonly renew  --standalone >> /var/log/docker_log/certbot_log

