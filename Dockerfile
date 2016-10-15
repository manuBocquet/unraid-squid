FROM debian:jessie
MAINTAINER manu <manu.bocquet@gmail.com>

ENV APTLIST="squid3 rsyslog" 

# install main packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /config
RUN sed -i -e's/.*ulimit.*//' /etc/init.d/squid3

ADD ./init.sh /etc/my_init.sh
RUN chmod 700 /etc/my_init.sh

CMD [ "/etc/my_init.sh" ]

# ports and volumes
EXPOSE 3128
VOLUME [ "/config" ]


