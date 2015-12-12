#!/bin/bash

QUERY="${1}"
case $QUERY in
	-g)	inbypass=$(route -n get default | grep 'gateway' | awk '{print $2}' | perl -pe 's/^(\d+\.\d+\.\d+\.)\d+/$1/ge')*
		exbypass=$( cat ~/.meow/direct | awk '{printf "%s ",$0}' | sed 's/,.$//' )
        sudo networksetup -setautoproxystate Ethernet off
		sudo networksetup -setsocksfirewallproxy Ethernet 127.0.0.1 1080
		sudo networksetup -setproxybypassdomains Ethernet $inbypass $exbypass
		label="Global Mode"
		;;
	-p)	TYPE="${2}"
		case $TYPE in
			b) pac="http://127.0.0.1:8090/proxy.pac"
				label="Blacklist PAC"
				;;
			w)	pac="http://127.0.0.1:8091/pac"
				label="Whitelist PAC"
				;;
		esac
		sudo networksetup -setsocksfirewallproxystate Ethernet off
		sudo networksetup -setautoproxyurl Ethernet $pac
		sudo networksetup -setproxybypassdomains Ethernet ""
		;;
	-h|--help)	
		echo "usage: `basename ${0}`: [-g] | [-p PACtype]

optional arguments:
 -h, --help		show this help
 -g				to Global Mode
 -p PAC			to PAC Mode, for example,
 				-p b	Blacklist PAC location
 				-p w	Whitelist PAC location"
		exit 1
		;;
	*)	
		echo "usage: `basename ${0}`: [-g] | [-p PACtype]"
		exit 1
		;;
esac
echo "Network has been set to $label."
