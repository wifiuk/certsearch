#!/bin/bash
# A quick and dirty script to do a wildcard query on Https://crt.sh to find subdomains using certs for domain
#
echo "Parsing input file and running search" 
for DOMAIN in $(cat $1); do
curl --progress-bar https://crt.sh/?q=%25.$DOMAIN | grep "<TD>" | egrep -v '(<TD><A)' | awk '{ print $1 }' | sed 's/....//' | sed -r 's/.{5}$//' | uniq -u > cert-output.txt
done
echo "Output results to cert-output.txt"
cat cert-output.txt
