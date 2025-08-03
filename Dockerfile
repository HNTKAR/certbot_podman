FROM python

ARG KEY_FILE

# https://eff-certbot.readthedocs.io/en/latest/using.html#dns-plugins
# https://certbot-dns-cloudflare.readthedocs.io/en/stable/
RUN apt -y update
RUN apt -y update 
RUN apt -y install python3-certbot python3-certbot-dns-cloudflare

COPY ["${KEY_FILE}","/key.ini"]
RUN chmod 600 /key.ini

ENTRYPOINT [ "certbot","certonly","--register-unsafely-without-email","--agree-tos","--dns-cloudflare","--dns-cloudflare-credentials" ,"/key.ini"]
CMD [ "--dry-run" ]