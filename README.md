#   PAControl

Just master your proxies.

##  Functions
1.  Switch within Global Proxies, supporting HTTP, SOCKS, etc.
2.  Switch between your PAC files, including local configurations.
3.  Auto bypass LAN and common domestic websites in China.
4.  More is comming soon.

##  Developing Process
- [x] Basic control
- [x] Bypass necessary addresses
- [ ] Using JSON to enrich extension
- [ ] Customize JSON databases

##  Examples
```
usage: sp.sh: [-g] | [-p PACtype]

optional arguments:
-h, --help     show this help
-g                to Global Mode
-p PAC           to PAC Mode, for example,
-p b    Blacklist PAC location
-p w    Whitelist PAC location
```