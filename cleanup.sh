#!/bin/bash

# Parameters
countries=( ru ua cn ng ro kp br in ir by gh za md il kz vn ae th id pk dz )


# Cleanup
echo ""
echo "#############################"
echo "Clearing existing rulesets..."
echo "#############################"
echo ""

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

for country in "${countries[@]}"
do
    echo "Destroying the IP set for $country IPv4..."
    ipset destroy $country-ipv4

    echo "Destroying the IP set for $country IPv6..."
    ipset destroy $country-ipv6
done


echo ""
echo "########"
echo "Finished"
echo "########"
echo ""
