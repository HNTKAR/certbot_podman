#!/bin/bash

domain="-d vpn.3birds.uk"
echo $@

chmod 600 /run/secrets/certbot_key
certbot certonly --register-unsafely-without-email --agree-tos --dns-cloudflare --dns-cloudflare-credentials /run/secrets/certbot_key $domain --keep-until-expiring $@
tail -f /dev/null