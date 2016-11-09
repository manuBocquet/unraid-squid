#!/bin/sh

function link {
	source = "$1"
	dest = "$2"
	if [ -f "${source}" ] || [ -d "${source}" ] ; then
		if [ ! -e "${dest}" ] ; then	
			if [ -f "${source}" ]; then
				rpath=$(dirname "${dest}")
				if [ ! -d "${rpath}" ]; then
					mkdir -p "${rpath}"
				fi
			mv "${source}" "${dest}"
		else
			rm -rf "${source}"
		fi		
	fi
	ln -s "${dest}" "${source}"	
}

# /etc/squid/squid.conf
link "/etc/squid/squid.conf" "/config/etc/squid.conf"

# /etc/syslog-ng/syslog-ng.conf
link "/etc/syslog-ng/syslog-ng.conf" "/config/etc/syslog-ng.conf"

# Set /var/log/squid
link "/var/log/squid" "/config/log"

# Launch Squid3
if [ -e "/var/run/squid.pid" ]; then
	rm "/var/run/squid.pid"
fi

exec /usr/sbin/squid3 -N >/config/log/squid_cmd.log 2>&1