FROM centos
MAINTAINER kusari-k

RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf install -y epel-release && \
	dnf install -y certbot && \
	dnf update -y && \
	dnf clean all

COPY setting.log run.sh /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
