#!/bin/bash

# Parameters
countries=( cn ru ua in ir vn br th id pk dz )


# Cleanup
echo "Clearing existing rulesets..."

for country in "${countries[@]}"
do
    echo "Removing any DROP rule for $country from INPUT IPv4 chain..."
    iptables -D INPUT -m set --match-set $country-ipv4 src -j DROP

    echo "Removing any DROP rule for $country from INPUT IPv6 chain..."
    ip6tables -D INPUT -m set --match-set $country-ipv6 src -j DROP

    echo "Removing any DROP rule for $country from DOCKER-USER IPv4 chain..."
    iptables -D DOCKER-USER -m set --match-set $country-ipv4 src -j DROP

    echo "Removing any DROP rule for $country from DOCKER-USER IPv6 chain..."
    ip6tables -D DOCKER-USER -m set --match-set $country-ipv6 src -j DROP
done

ipset destroy


# Preparing
echo "Creating the IP sets..."

for country in "${countries[@]}"
do
    echo "Creating the IP set for $country IPv4..."
    ipset create $country-ipv4 hash:net family inet

    echo "Creating the IP set for $country IPv6..."
    ipset create $country-ipv6 hash:net family inet6
done

echo "Removing any old zone files that might exist from previous runs of this script..."
rm -rfv /tmp/ipblocks/


# Downloading country data
echo "Pulling the latest IP sets for required countries..."

mkdir -p /tmp/ipblocks/ipv4/
mkdir -p /tmp/ipblocks/ipv6/

for country in "${countries[@]}"
do
    echo "Downloading aggregated country IPv4 block file for $country..."
    wget -nv -P /tmp/ipblocks/ipv4/ https://www.ipdeny.com/ipblocks/data/aggregated/$country-aggregated.zone

    echo "Downloading aggregated country IPv6 block file for $country..."
    wget -nv -P /tmp/ipblocks/ipv6/ https://www.ipdeny.com/ipv6/data/aggregated/$country-aggregated.zone
done


# Creating IP sets
echo "Adding each IP address from the downloaded lists into the respective IP sets..."

for country in "${countries[@]}"
do
    echo "Adding $country IPv4 block file into $country IP set..."
    for i in $(cat /tmp/ipblocks/ipv4/$country-aggregated.zone )
    do
        ipset -A $country-ipv4 $i
    done

    echo "Adding $country IPv6 block file into $country IP set..."
    for i in $(cat /tmp/ipblocks/ipv6/$country-aggregated.zone )
    do
        ipset -A $country-ipv6 $i
    done
done


# Adding firewall rules
echo "Creating iptables rules..."

for country in "${countries[@]}"
do
    echo "Creating DROP rule for $country in INPUT IPv4..."
    iptables -I INPUT -m set --match-set china-ipv4 src -j DROP

    echo "Creating DROP rule for $country in INPUT IPv6..."
    ip6tables -I INPUT -m set --match-set china-ipv6 src -j DROP

    echo "Creating DROP rule for $country in DOCKER-USER IPv4..."
    iptables -I DOCKER-USER -m set --match-set china-ipv4 src -j DROP

    echo "Creating DROP rule for $country in DOCKER-USER IPv6..."
    ip6tables -I DOCKER-USER -m set --match-set china-ipv6 src -j DROP
done

echo "Finished"
