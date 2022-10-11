FROM rockylinux:9

ARG DOMAIN
ARG KEY_FILE
ARG DRY_RUN_FLAG=""
ENV FLAG=${DRY_RUN_FLAG:+"--dry-run"}
ENV DOMAIN=${DOMAIN}
ENV MAIL="--register-unsafely-without-email"

RUN dnf -y update && \
	dnf -y install python3-pip && \
	pip install certbot certbot-dns-google

COPY ["${KEY_FILE}","/key.json"]
COPY ["run.sh", "/usr/local/bin/"]
RUN chmod 600 /key.json
RUN chmod 777 -R /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/run.sh"]