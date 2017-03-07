#docker run -d --name="manu_squid3" -h squid3 -v /mnt/user/appdata/squid3:/config -p 3128:3128 squid3
docker run -d --name="manu_squid3" -h squid3 -v /mnt/user/appdata/squid3/etc:/config -v  /mnt/user/appdata/squid3/log:/var/log/squid -p 3128:3128 squid3
