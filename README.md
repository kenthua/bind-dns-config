# BIND DNS Configuration sample, for example.com and wildcard example

Source
------

install instructions: http://www.itzgeek.com/how-tos/linux/centos-how-tos/configure-dns-bind-server-on-centos-7-rhel-7.html#axzz3ZCAxA2oC

Run With Docker
---------------
`docker build -t <tag_name> .`

`docker run --privileged -d -p 53:53/udp -v /sys/fs/cgroup:/sys/fs/cgroup <tag_name>`

* --privileged mode for SELinux
* -d for detached
* -p port mapping 53/udp
* -v mount volume of host for cgroup (to run systemd)


Install Digest
--------------

Install Bind
`yum install bind bind-utils`

Modify config files

Update dns resolution /etc/resolv.conf or ifcfg-ethx DNS reference

It appears named service needs a restart for any config/db change based on current configuration
`systemctl restart named.service`

To do a quick test - should resolve correct IP
`dig www.example.com`

Testing reverse IP dns lookup
`dig -x 10.211.55.2`


Config Files
------------

named.conf - location /etc

commented out listen-on port 53... & listen-on-v6 port 53... in force bind to listen on all interfaces

added allow-query 10.211.55.0/24 so that local ip's can query

added forwarders 8.8.8.8 to query google dns for anything not defined in local dns (i.e. example.com)



fwd.example.com - location /var/named

TTL @ 300
ose3-master 300 IN A 10.211.55.36
*.cloudapps 300	IN A 10.211.55.36

55.211.10.db	- location /var/named


