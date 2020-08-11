FROM centos
MAINTAINER kusari-k

RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y epel-release && \
	dnf update -y && \
	dnf install -y certbot && \
	dnf clean all

COPY setting.log run.sh /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
