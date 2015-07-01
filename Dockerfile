FROM centos:latest
#FROM registry.access.redhat.com/rhel:latest
MAINTAINER kent@pitchdarkice.com 

ADD named.conf /etc/named.conf
ADD cloudapps.example.com.db /var/named/dynamic/cloudapps.example.com.db
ADD example.com.db /var/named/dynamic/example.com.db

RUN yum -y update; yum clean all
RUN yum -y install bind bind-utils; yum clean all; systemctl enable named.service

EXPOSE 53/udp
CMD ["/usr/sbin/init"]

