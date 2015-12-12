#!/bin/bash

QUERY="${1}"
cmdp="sudo networksetup -setautoproxyurl Ethernet"
case $QUERY in
	-g)	
		sudo networksetup -setsocksfirewallproxy Ethernet 127.0.0.1 1080
		sudo networksetup -setproxybypassdomains Ethernet "192.168.1.*" baidu.com
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
		echo $cmdp $pac | bash
		;;
	*)	
		echo "`basename ${0}`:	usage: [-g] | [-p PACtype]"
		exit 1
		;;
esac
echo "Network has been set to $label."