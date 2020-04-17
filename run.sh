#!/usr/bin/bash
date >> /var/log/SSL.log
/usr/local/bin/certbot-auto certonly renew --standalone>>/var/log/SSL.log
sed -ze "s/\n/:/g" -e "s/\ /,/g" /usr/local/bin/system.log | \
        xargs -n 2 -d ":" bash -c '/usr/local/bin/certbot-auto certonly --standalone --expand --domains $1 --agree-tos --email $0  --no-eff-email --keep>>/var/log/SSL.log && \
        sleep 10'
