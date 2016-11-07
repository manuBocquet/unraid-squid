FROM phusion/baseimage:0.9.19
MAINTAINER manu <manu.bocquet@gmail.com>

ENV APTLIST="squid3" 
ENV SYSLOG_ADDR="192.168.1.5:514"

# install main packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /config
RUN mkdir /etc/service/squid3
ADD ./init.sh /etc/service/squid3/run
RUN chmod 755 /etc/service/squid3/run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ports and volumes
EXPOSE 3128
VOLUME [ "/config" ]


