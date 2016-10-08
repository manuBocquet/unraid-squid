FROM debian:jessie
MAINTAINER manu <manu.bocquet@gmail.com>

RUN apt-get update && apt-get install -y \
	squid3

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
	/usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ports and volumes
EXPOSE 3138
VOLUME /etc/squid3
