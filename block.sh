#!/bin/bash

# Cleanup
echo "Clearing existing rulesets..."
iptables -D INPUT -m set --match-set china-ipv4 src -j DROP
iptables -D INPUT -m set --match-set russia-ipv4 src -j DROP
iptables -D INPUT -m set --match-set ukraine-ipv4 src -j DROP
iptables -D INPUT -m set --match-set india-ipv4 src -j DROP
iptables -D INPUT -m set --match-set iran-ipv4 src -j DROP
iptables -D INPUT -m set --match-set vietnam-ipv4 src -j DROP
iptables -D INPUT -m set --match-set brazil-ipv4 src -j DROP
iptables -D INPUT -m set --match-set thailand-ipv4 src -j DROP
iptables -D INPUT -m set --match-set indonesia-ipv4 src -j DROP
iptables -D INPUT -m set --match-set pakistan-ipv4 src -j DROP
iptables -D INPUT -m set --match-set algeria-ipv4 src -j DROP

ip6tables -D INPUT -m set --match-set china-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set russia-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set ukraine-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set india-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set iran-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set vietnam-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set brazil-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set thailand-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set indonesia-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set pakistan-ipv6 src -j DROP
ip6tables -D INPUT -m set --match-set algeria-ipv6 src -j DROP

iptables -D DOCKER-USER -m set --match-set china-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set russia-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set ukraine-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set india-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set iran-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set vietnam-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set brazil-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set thailand-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set indonesia-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set pakistan-ipv4 src -j DROP
iptables -D DOCKER-USER -m set --match-set algeria-ipv4 src -j DROP

ip6tables -D DOCKER-USER -m set --match-set china-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set russia-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set ukraine-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set india-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set iran-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set vietnam-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set brazil-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set thailand-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set indonesia-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set pakistan-ipv6 src -j DROP
ip6tables -D DOCKER-USER -m set --match-set algeria-ipv6 src -j DROP

ipset destroy


# Preparing
echo "Creating the ipset lists..."
ipset create china-ipv4 hash:net family inet
ipset create china-ipv6 hash:net family inet6
ipset create russia-ipv4 hash:net family inet
ipset create russia-ipv6 hash:net family inet6
ipset create ukraine-ipv4 hash:net family inet
ipset create ukraine-ipv6 hash:net family inet6
ipset create india-ipv4 hash:net family inet
ipset create india-ipv6 hash:net family inet6
ipset create iran-ipv4 hash:net family inet
ipset create iran-ipv6 hash:net family inet6
ipset create vietnam-ipv4 hash:net family inet
ipset create vietnam-ipv6 hash:net family inet6
ipset create brazil-ipv4 hash:net family inet
ipset create brazil-ipv6 hash:net family inet6
ipset create thailand-ipv4 hash:net family inet
ipset create thailand-ipv6 hash:net family inet6
ipset create indonesia-ipv4 hash:net family inet
ipset create indonesia-ipv6 hash:net family inet6
ipset create pakistan-ipv4 hash:net family inet
ipset create pakistan-ipv6 hash:net family inet6
ipset create algeria-ipv4 hash:net family inet
ipset create algeria-ipv6 hash:net family inet6


echo "Removing any old zone files that might exist from previous runs of this script..."
rm -f /tmp/ipblocks/ipv4/*.zone
rm -f /tmp/ipblocks/ipv6/*.zone


# Assembling
echo "Pulling the latest IP sets for required countries..."
mkdir -p /tmp/ipblocks/ipv4/
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/cn-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/ru-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/ua-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/in-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/ir-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/vn-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/br-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/th-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/id-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/pk-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/dz-aggregated.zone

mkdir -p /tmp/ipblocks/ipv6/
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/cn-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/ru-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/ua-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/in-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/ir-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/vn-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/br-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/th-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/id-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/pk-aggregated.zone
wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/ipaddresses/aggregated/dz-aggregated.zone


echo "Adding each IP address from the downloaded lists into the respective ipsets..."
echo "China..."
for i in $(cat /tmp/ipblocks/ipv4/cn-aggregated.zone ); do ipset -A china-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/cn-aggregated.zone ); do ipset -A china-ipv6 $i; done
echo "Russia..."
for i in $(cat /tmp/ipblocks/ipv4/ru-aggregated.zone ); do ipset -A russia-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/ru-aggregated.zone ); do ipset -A russia-ipv6 $i; done
echo "Ukraine..."
for i in $(cat /tmp/ipblocks/ipv4/ua-aggregated.zone ); do ipset -A ukraine-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/ua-aggregated.zone ); do ipset -A ukraine-ipv6 $i; done
echo "India..."
for i in $(cat /tmp/ipblocks/ipv4/in-aggregated.zone ); do ipset -A india-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/in-aggregated.zone ); do ipset -A india-ipv6 $i; done
echo "Iran..."
for i in $(cat /tmp/ipblocks/ipv4/ir-aggregated.zone ); do ipset -A iran-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/ir-aggregated.zone ); do ipset -A iran-ipv6 $i; done
echo "Vietnam..."
for i in $(cat /tmp/ipblocks/ipv4/vn-aggregated.zone ); do ipset -A vietnam-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/vn-aggregated.zone ); do ipset -A vietnam-ipv6 $i; done
echo "Brazil..."
for i in $(cat /tmp/ipblocks/ipv4/br-aggregated.zone ); do ipset -A brazil-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/br-aggregated.zone ); do ipset -A brazil-ipv6 $i; done
echo "Thailand..."
for i in $(cat /tmp/ipblocks/ipv4/th-aggregated.zone ); do ipset -A thailand-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/th-aggregated.zone ); do ipset -A thailand-ipv6 $i; done
echo "Indonesia..."
for i in $(cat /tmp/ipblocks/ipv4/id-aggregated.zone ); do ipset -A indonesia-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/id-aggregated.zone ); do ipset -A indonesia-ipv6 $i; done
echo "Pakistan..."
for i in $(cat /tmp/ipblocks/ipv4/pk-aggregated.zone ); do ipset -A pakistan-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/pk-aggregated.zone ); do ipset -A pakistan-ipv6 $i; done
echo "Algeria..."
for i in $(cat /tmp/ipblocks/ipv4/dz-aggregated.zone ); do ipset -A algeria-ipv4 $i; done
for i in $(cat /tmp/ipblocks/ipv6/dz-aggregated.zone ); do ipset -A algeria-ipv6 $i; done


# Adding firewall rules
echo "Creating iptables rules..."
iptables -I INPUT -m set --match-set china-ipv4 src -j DROP
iptables -I INPUT -m set --match-set russia-ipv4 src -j DROP
iptables -I INPUT -m set --match-set ukraine-ipv4 src -j DROP
iptables -I INPUT -m set --match-set india-ipv4 src -j DROP
iptables -I INPUT -m set --match-set iran-ipv4 src -j DROP
iptables -I INPUT -m set --match-set vietnam-ipv4 src -j DROP
iptables -I INPUT -m set --match-set brazil-ipv4 src -j DROP
iptables -I INPUT -m set --match-set thailand-ipv4 src -j DROP
iptables -I INPUT -m set --match-set indonesia-ipv4 src -j DROP
iptables -I INPUT -m set --match-set pakistan-ipv4 src -j DROP
iptables -I INPUT -m set --match-set algeria-ipv4 src -j DROP

ip6tables -I INPUT -m set --match-set china-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set russia-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set ukraine-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set india-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set iran-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set vietnam-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set brazil-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set thailand-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set indonesia-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set pakistan-ipv6 src -j DROP
ip6tables -I INPUT -m set --match-set algeria-ipv6 src -j DROP

iptables -I DOCKER-USER -m set --match-set china-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set russia-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set ukraine-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set india-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set iran-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set vietnam-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set brazil-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set thailand-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set indonesia-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set pakistan-ipv4 src -j DROP
iptables -I DOCKER-USER -m set --match-set algeria-ipv4 src -j DROP

ip6tables -I DOCKER-USER -m set --match-set china-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set russia-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set ukraine-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set india-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set iran-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set vietnam-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set brazil-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set thailand-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set indonesia-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set pakistan-ipv6 src -j DROP
ip6tables -I DOCKER-USER -m set --match-set algeria-ipv6 src -j DROP
