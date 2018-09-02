#!/bin/sh
old_server_internal_ip=$(grep "left=" /etc/ipsec.conf | awk 'BEGIN{FS="="} {print $2}')
new_server_internal_ip=$(ifconfig eth0 | awk 'BEGIN{FS=":"} /inet addr/{print $2}'|awk '{print $1}')
echo "old_server_internal_ip: $old_server_internal_ip"
echo "new_server_internal_ip: $new_server_internal_ip"
#old_server_internal_ip="172.26.6.244"
#new_server_internal_ip="172.26.1.210"
sed -i "s/$old_server_internal_ip/$new_server_internal_ip/" /etc/ipsec.conf
sed -i "s/$old_server_internal_ip/$new_server_internal_ip/" /etc/iptables.rules
sed -i "s/$old_server_internal_ip/$new_server_internal_ip/" /etc/rc.local

sh /etc/rc.local
service ipsec start
service xl2tpd start 
iptables-restore < /etc/iptables.rules
#reboot
