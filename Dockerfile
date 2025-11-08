FROM python

# https://eff-certbot.readthedocs.io/en/latest/using.html#dns-plugins
# https://certbot-dns-cloudflare.readthedocs.io/en/stable/
RUN apt -y update
RUN apt -y update 
RUN apt -y install python3-certbot python3-certbot-dns-cloudflare
RUN apt -y install bash

COPY ["run.sh","/usr/local/bin/"]
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]