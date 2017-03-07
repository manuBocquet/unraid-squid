#!/bin/sh

link () {
        source="$1"
        dest="$2"
        if [ -f "${source}" ] || [ -d "${source}" ] ; then
                if [ ! -e "${dest}" ] ; then
                        if [ -f "${source}" ]; then
                                rpath=$(dirname "${dest}")
                                if [ ! -d "${rpath}" ]; then
                                        mkdir -p "${rpath}"
                                fi
                        fi
                        mv "${source}" "${dest}"
                else
                        rm -rf "${source}"
                fi
        fi
        ln -s "${dest}" "${source}"
}

# /etc/squid/squid.conf
link "/etc/squid/squid.conf" "/config/squid.conf"
link "/var/spool/cron/crontabs/root" "/config/root_crontab"
link "/root/proxy_cron.sh" "/config/proxy_cron.sh"

# /etc/syslog-ng/syslog-ng.conf
link "/etc/syslog-ng/syslog-ng.conf" "/config/syslog-ng.conf"

# Launch Squid3
if [ -e "/var/run/squid.pid" ]; then
	rm "/var/run/squid.pid"
fi

if [ -r "/config/proxy_cron" ] ; then
	crontab /config/proxy_cron
fi
	
exec /usr/sbin/squid3 -N 
