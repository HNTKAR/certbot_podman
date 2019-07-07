FROM centos
MAINTAINER kusari-k

EXPOSE 80

RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y certbot
RUN yum clean all

RUN mkdir /var/log/docker_log

COPY myapp.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/myapp.sh
ENTRYPOINT ["/usr/local/bin/myapp.sh"]
