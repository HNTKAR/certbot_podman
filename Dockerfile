FROM centos
MAINTAINER kusari-k

EXPOSE 80

RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y wget && \
	dnf clean all

RUN wget https://dl.eff.org/certbot-auto && \
	mv certbot-auto /usr/local/bin/certbot-auto && \
	chmod 755 /usr/local/bin/certbot-auto

COPY system.log  /usr/local/bin/
COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
