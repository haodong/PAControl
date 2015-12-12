#!/bin/bash

checkHTTP="networksetup -getwebproxy Ethernet | grep '^Enabled' | awk '{print \$2}'"
checkHTTPS="networksetup -getsecurewebproxy Ethernet | grep '^Enabled' | awk '{print \$2}'"
checkSOCKS="networksetup -getsocksfirewallproxy Ethernet | grep '^Enabled' | awk '{print \$2}'"
usage="usage: `basename ${0}`: [-h|--help] [-b on|off] [-g <proxy>] [-p PACtype]"
while getopts b:g:p:h opt
do
	case "$opt" in
		g)	case $OPTARG in
	            ss)
	            	sudo networksetup -setsocksfirewallproxy Ethernet 127.0.0.1 1080
	            	sudo networksetup -setsecurewebproxystate Ethernet off
	                ;;
	            gae)
	            	sudo networksetup -setsecurewebproxy Ethernet 127.0.0.1 8087
	            	sudo networksetup -setsocksfirewallproxystate Ethernet off
	                ;;
				*)
					echo "`basename ${0}`: illegal option -- $OPTARG"; echo $usage; exit 1
					;;
	        esac
	        sudo networksetup -setautoproxystate Ethernet off
	        echo "Network has been set to Global Mode."
	        echo "`basename ${0}` -b on" | bash
			;;
		p)	case $OPTARG in
				b|black)  pac="http://127.0.0.1:8090/proxy.pac"
	        		echo "Network has been set to Blacklist PAC."
					;;
				w|white)	pac="http://127.0.0.1:8091/pac"
	        		echo "Network has been set to Whitelist PAC."
					;;
				*)
					echo "`basename ${0}`: illegal option -- $OPTARG"; echo $usage; exit 1
					;;
			esac
			sudo networksetup -setautoproxyurl Ethernet $pac
			sudo networksetup -setsecurewebproxystate Ethernet off
			sudo networksetup -setsocksfirewallproxystate Ethernet off
	        echo "`basename ${0}` -b off" | bash
			;;
		b)	case $OPTARG in
				on)	
					inbypass=$(route -n get default | grep 'gateway' | awk '{print $2}' | perl -pe 's/^(\d+\.\d+\.\d+\.)\d+/$1/ge')*
					exbypass=$(cat ~/.meow/direct | awk '{printf "%s ",$0}' | sed 's/,.$//')
					sudo networksetup -setproxybypassdomains Ethernet $inbypass $exbypass
					;;
				off)
					sudo networksetup -setproxybypassdomains Ethernet ""
					;;
				*)
					echo "`basename ${0}`: illegal option -- $OPTARG"; echo $usage; exit 1
					;;
			esac
			;;
		h)
			echo $usage
			echo '
optional arguments:
	-h, --help		show this help
	-g <proxy>		to Global Mode, including "-b on", e.g.,
		-g ss			Shadowsocks with Bypass (default)
		-g gae -b off		GoAgent without Bypass (manually)
	-p <pac>		to PAC Mode, including "-b off", e.g.,
		-p b|black		Blacklist without Bapass (default)
		-p w|white -b on	Whitelist with Bypass (manually)
	-b <on|off>		to switch Bypass
		-b on			Enable Bypass
		-b off 			Disable Bypass'
			exit 1
			;;
		*)	
			echo "`basename ${0}`: illegal option -- $opt"
			echo $usage
			exit 1
			;;
	esac
done
