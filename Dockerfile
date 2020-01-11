FROM centos
MAINTAINER kusari-k

EXPOSE 80

RUN yum update -y
RUN yum install -y wget
RUN yum clean all

RUN mkdir -p /var/log/docker_log

COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
