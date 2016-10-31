#!/bin/bash

# Set /config/etc

if [ ! -d "/config/etc" ]; then
	mkdir -p /config/etc 
fi

if [[ ! -f "/config/etc/squid.conf" && -f "/etc/squid3/squid.conf" ]]; then 
	mv /etc/squid3/squid.conf /config/etc/
fi

if [ -f "/config/etc/squid.conf" ]; then
	rm /etc/squid3/squid.conf
	ln -s /config/etc/squid.conf /etc/squid3/squid.conf  
fi

# Set /config/log

if [[ ! -d "/config/log" && -d "/var/log/squid3" ]]; then
	mv /var/log/squid3 /config/log
fi

if [ ! -h "/var/log/squid3" ]; then
	rm -rf /var/log/squid3
	ln -s /config/log /var/log/squid3
fi

# Launch Squid3

env > /config/log/env.txt

sed -i -e's/.*ulimit.*//' /etc/init.d/squid3
echo "access_log syslog:local2.info squid" >> /etc/squid3/squid.conf

/usr/sbin/squid3 -N >/config/log/squid3.log 2>&1
