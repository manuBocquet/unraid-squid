FROM debian:jessie
MAINTAINER manu <manu.bocquet@gmail.com>

ENV APTLIST="squid3 vim lsof" 

# install main packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /config/etc
RUN mkdir -p /config/log
RUN sed -i -e's/.*ulimit.*//' /etc/init.d/squid3
ADD ./init.sh /config/init.sh
RUN chmod 700 /config/init.sh
RUN ln -s /etc/squid3/squid3.conf /config/etc/squid3.conf
RUN ln -s /var/log/squid3 /config/log

CMD [ "/config/init.sh" ]

# ports and volumes
EXPOSE 3128
VOLUME [ "/config" ]


