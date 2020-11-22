#!/bin/bash
#AUTHOR: Daniele Volpe  https://github.com/DenFox93

domain=$1
echo > domains.txt
while true; do
	value=$(dig -t nsec $domain +short | awk '{print $1;}' )
	domain=$value
	lines1=$(grep -c ^ domains.txt)
	grep -qxF -- "$domain" "domains.txt" || echo "$domain" |& tee -a "domains.txt"
	lines2=$(grep -c ^ domains.txt)
	if [[ $lines2 -eq 1 ]]; then
		echo "Sorry i have not found NSEC records :("
	fi
	if [[ $lines2 -eq $lines1 ]]; then
		break
	fi
done
