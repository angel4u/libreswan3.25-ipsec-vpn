#!/bin/sh
root_path=~
#delete old user
${root_path}/All-in-One-VPN/scripts/manageuser.sh -d -u guest
#add guest user
new_pwd=hackme$(date +%s |cut -c 7-10)
${root_path}/All-in-One-VPN/scripts/manageuser.sh -a -u guest -p $new_pwd
#update and sync guest_pwd.conf
grep "^guest " /etc/ppp/chap-secrets | awk '{print $3}' > ${root_path}/Website/guest_pwd.conf
#cat ${root_path}/Website/guest_pwd.conf
${root_path}/All-in-One-VPN/scripts/sync2server.sh sg.petersvpn.com ~/Website/guest_pwd.conf