#!/bin/sh
#
#
This script is designed to stop nmap, zenmap and other types of portscans
### Flush al the iptabel Rules
iptables -F

# INPUT iptables rules
# Accept loopback input
iptable -A INPUT -i lo -p all -j ACCEPT

#allow 3way handshake
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

### Drop spoofing packets
iptables -A INPUT -s 10.0.0.0/8 -j DROP
iptables -A INPUT -s 192.168.1.0/24 -j DROP
iptables -A INPUT -s 192.168.1.1/24 -j DROP
iptables -A INPUT -s 127.0.0.0./8 -j DROP

#Drop all invalid packets
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A FORWARD -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP

#Protecting portstacns
#Attacking IP will be locked for 24 hours
iptables -A INPUT -m recent --name portscan --rcheck --seconds 86400 -j DROP
iptables -A FORWARD -m recent --name portscan --rcheck --seconds 86400 -j DROP

#Removal of an attacking IP after 24 hours
iptables -A INPUT -m recent --name portscan --remove
iptables -A FORWARD -m recent --name portscan --remove 

# Allow ping means ICMP port is open (for no-ping rule: replace ACCEPT with REJECT)
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Allow the following ports through from outside
iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

# Reject All INPUT traffic
iptables -A INPUT -j REJECT

