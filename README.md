#   PAControl

Just master your proxies.

##  Functions
1.  Switch within Global Proxies, supporting HTTP, SOCKS, etc.
2.  Switch between your PAC files, including local configurations.
3.  Auto bypass LAN and commonly domestic website addresses in China.
4.  More is comming soon.

##  Cautions
-	This tool is designed for people who need to frequently switch between different proxies. Therefore, by using it, you are supposed having been using the following software:
	- [Mavericks](https://en.wikipedia.org/wiki/OS_X_Mavericks): It maybe compatible to your OSX, but there is **NO** guarantee for potential risks.
	- [Goagent](https://github.com/goagent/goagent)
	- [Shadowsocks](https://github.com/shadowsocks/shadowsocks)
	- [ShadowsocksX](https://github.com/shadowsocks/shadowsocks-iOS/wiki/Shadowsocks-for-OSX-Help)
	- [MEOW](https://github.com/renzhn/MEOW)
-	Free as it is, **NO** warrant is provided. In effect, I code and share it just for studying. Users should not use it for illegal purposes.

##  Developing Process
- [x] PAC
- [x] Global
- [x] Bypass
- [x] Multiple options
- [ ] JSON extension
- [ ] Customize proxiy configurations 

##  Usage
```
>sp -h
usage: sp: [-h|--help] [-b on|off] [-g <proxy>] [-p PACtype]

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
		-b off 			Disable Bypass
```

##  Examples
1.	to ss

	```
	>sp -g ss
	Password:
	Network has been set to Global Mode.
	```
	![ss](examples/ss.png)
2.	to gae without bypass

	```
	>sp -g gae -b off
	Network has been set to Global Mode.
	```
	![gae](examples/gae.png)
3. to whitelist

	```
	sp -p b
	Network has been set to Blacklist PAC.
	```
	![black](examples/black.png)
4. to blacklist with bypass

	```
	sp -p white -b on
	Network has been set to Whitelist PAC.
	```
	![white](examples/white.png)

##  License
[GPL v3.0](https://github.com/haodong/pacontrol/blob/master/LICENSE)
