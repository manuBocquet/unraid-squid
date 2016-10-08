FROM debian:jessie
MAINTAINER manu <manu.bocquet@gmail.com>

ENV APTLIST="squid3 vim lsof" 

# install main packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i -e's/.*ulimit.*//' /etc/init.d/squid3
ADD ./test.sh /root/test.sh
RUN /root/test.sh

# ports and volumes
EXPOSE 3138
VOLUME /config


