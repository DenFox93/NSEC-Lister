#!/bin/bash
#AUTHOR: Daniele Volpe
domainsDiscoveredNew=$1
echo > domains.txt
while IFS= read -r line; do
	while true; do
	value=$(dig -t nsec $line +short | awk '{print $1;}' )
	line=$value
	lines1=$(grep -c ^ domains.txt)
	grep -qxF -- "$line" "domains.txt" || echo "$line" |& tee -a "domains.txt"
	lines2=$(grep -c ^ domains.txt)
	if [[ $lines2 -eq 1 ]]; then
		echo "i have not found NSEC records"
	fi
	if [[ $lines2 -eq $lines1 ]]; then
		break
	fi
	done	
done < $domainsDiscoveredNew
