#!/bin/bash

HOST=$(hostname)
NICS=$(nmcli dev | tail -n +2 | grep -v '^lo' | awk '{print $1}')

echo "Host Name ............ : $HOST"

for NIC in $NICS
do

CON=$(nmcli dev show $NIC | grep 'GENERAL.CONNECTION:' | awk '{print $2}')
IP=$(nmcli dev show $NIC | grep 'IP4.ADDRESS' | awk '{print $2}')
GW=$(nmcli dev show $NIC | grep 'IP4.ADDRESS' | awk '{print $2}')
DNS=$(nmcli dev show $NIC | grep 'IP4.DNS' | awk '{print $2}')

cat <<EOF
Connection Name ...... : $CON
Ethernet adapter ..... : $NIC
IPv4 Address ......... : $IP
Default Gateway ...... : $GW
DNS Servers .......... : $DNS

EOF

done
