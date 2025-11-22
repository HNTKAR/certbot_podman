#!/bin/bash

chmod 777 -R /V

echo $@

chmod 600 /run/secrets/certbot_key
certbot certonly --register-unsafely-without-email --agree-tos --dns-cloudflare --dns-cloudflare-credentials /run/secrets/certbot_key $DOMAIN --keep-until-expiring $@|\
        tee /V/certbot.log
