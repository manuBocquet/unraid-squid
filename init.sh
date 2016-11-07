#!/bin/sh

# Set /config/etc

if [ ! -d "/config/etc" ]; then
	mkdir -p /config/etc 
fi

if [ ! -d "/config/log" ]; then
	mkdir -p /config/log
fi

# /etc/squid/squid.conf
if [ ! -f "/config/etc/squid.conf" ]; then 
	mv /etc/squid/squid.conf /config/etc/
fi

if [ ! -h "/config/etc/squid.conf" ]; then
	rm /etc/squid/squid.conf
	ln -s /config/etc/squid.conf /etc/squid/squid.conf  
fi

# /etc/syslog-ng/syslog-ng.conf
if [ ! -f "/config/etc/syslog-ng.conf" ]; then
	mv /etc/syslog-ng/syslog-ng.conf /config/etc/syslog-ng.conf
fi

if [ ! -h "/config/etc/syslog-ng.conf" ]; then
	rm /etc/syslog-ng/syslog-ng.conf
	ln -s /config/etc/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
fi

# Set /var/log/squid
if [ ! -d "/config/log" ] && [ -d "/var/log/squid" ]; then
	mv /var/log/squid /config/log
fi

if [ ! -h "/var/log/squid" ]; then
	rm -rf /var/log/squid
	ln -s /config/log /var/log/squid
fi

# Launch Squid3

env > /config/log/env.txt

#sed -i -e's/.*ulimit.*//' /etc/init.d/squid3
#echo "access_log syslog:local2.info squid" >> /etc/squid3/squid.conf

exec /usr/sbin/squid3 -N >/config/log/squid3.log 2>&1
