FROM python

ARG KEY_FILE

RUN pip install certbot certbot-dns-cloudflare certbot-dns-google

COPY ["${KEY_FILE}","/key.ini"]
# COPY ["${KEY_FILE}","/key.json"]
RUN chmod 600 /key.ini
ENTRYPOINT [ "certbot","certonly","--agree-tos","--dns-cloudflare","--register-unsafely-without-email","--dns-cloudflare-credentials" ,"/key.ini"]
# CMD [ "--dry-run" ]