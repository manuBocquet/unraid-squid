#!/bin/sh

## get new ad server list
wget -O /config/ad_block.txt 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=squid-dstdom-regex&showintro=0&mimetype=plaintext' 

if [ $? -eq 0 ]; then
	kill -HUP `cat /var/run/squid.pid`
fi
