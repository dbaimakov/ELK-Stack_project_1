#!/bin/sh

# This script should be used with the conjunction of INPUTiptablesh.sh script

## Allow loopback OUTPUT 
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow for ports:
# SMTP = 25
# DNS =53
# HTTP = 80
# HTTPS = 443
# SSH = 22
iptables -A OUTPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 22 -j ACCEPT

# Allow pings
iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Reject all Output traffic
iptables -A OUTPUT -j REJECT

## Reject Forward  traffic
iptables -A FORWARD -j REJECT

#For extra security once you have run this script make sure Read and Write Execute permissionals are to root user with chmod 700/root/OUTPUTiptables.sh command
