FROM centos:latest
#FROM registry.access.redhat.com/rhel:latest
MAINTAINER kent@pitchdarkice.com 

ADD named.conf /etc/named.conf
ADD fwd.example.com.zone /var/named/fwd.example.com.zone

RUN yum -y update; yum clean all
RUN yum -y install bind bind-utils; systemctl enable named.service

EXPOSE 53/udp
CMD ["/usr/sbin/init"]

