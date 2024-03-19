FROM python

ARG KEY_FILE

# https://eff-certbot.readthedocs.io/en/latest/packaging.html
# https://eff-certbot.readthedocs.io/en/latest/using.html#dns-plugins
RUN pip install certbot-dns-cloudflare

COPY ["${KEY_FILE}","/key.ini"]
RUN chmod 600 /key.ini
ENTRYPOINT [ "certbot","certonly","--register-unsafely-without-email","--agree-tos","--dns-cloudflare","--dns-cloudflare-credentials" ,"/key.ini"]
CMD [ "--dry-run" ]