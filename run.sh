#!/bin/bash

echo $@

chmod 600 /run/secrets/certbot_key
certbot certonly --register-unsafely-without-email --agree-tos --dns-cloudflare --dns-cloudflare-credentials /run/secrets/certbot_key $DOMAIN --keep-until-expiring $@