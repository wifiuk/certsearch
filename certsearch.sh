#!/bin/bash
# A quick and dirty script to do a wildcard query on Https://crt.sh to find subdomains using certs for domain
#
IFS=$'\n' #make newlines the only separator
echo "Parsing input file and running search" 
for DOMAIN in $(cat $1); do
curl --progress-bar https://crt.sh/?q=%25.$DOMAIN | grep "<TD>" | egrep -v '(<TD><A)' | awk '{ print $1 }' | sed 's/....//' | sed -r 's/.{5}$//' | sort -u >> cert-output.txt
done

echo "showing results and saving to file"
cat cert-output.txt
