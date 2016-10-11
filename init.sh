#!/bin/bash

if [ ! -d "/config/etc" ]; then
	mkdir -p /config/etc 
fi

if [ ! -d "/config/log" ]; then
	mkdir -p /config/log
fi

if [ -f "/etc/squid3/squid.conf" ]; then
	mv /etc/squid3/squid.conf /config/etc/ && \
	ln -s /config/etc/squid.conf /etc/squid3/squid.conf  
fi

if [ -d "/var/log/squid3" ]; then
	mv /var/log/squid3 /config/log && \
	ln -s /config/log /var/log/squid3
fi

/usr/sbin/squid3 -N
