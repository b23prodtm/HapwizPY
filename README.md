# HapwizPY
 Host access point Wizard script for Debian/Ubuntu

# Usage
Basically, this script's made for linux machines that have got a wireless card or chipset and an ethernet interface connected to the internet. Following the wizard script to install hostapd and its dependencies on the machine : ```scripts/hap-wiz-bionic.sh [-c,--client] <priv-network-x.x.x.0/len> <wan-network-x.x.x.0/len> <wan-interface> [ssid passphrase [mode] [country_code channel] [net-range-start net-range-end] [priv-network-ipv6/mask-length wan-network-ipv6/mask-length]]```

Here follows a sample command line of a host access point acting as a router on the local network 192.168.0.0/24 (ISP router setup). Routing Broadband Internet Connection from  Ethernet (eth0) via Wireless Card (wlan0: ip adresses 10.0.1.x) and open a HomeWifiNet WPA-PSK secured Wifi network, try :

  ```scripts/hap-wiz-bionic.sh 10.0.1.0/24 192.168.0.0/24 eth0 HomeWifiNet OneWPAssword a US 36```

For instance, use channel 6 for b/g/n 2,4GHz or channel 36 for ac 5GHz. Usually set to an automatic channel selection [0] doesn't work with some wifi chipsets (see manufacturer's specifications).

The host must have access to the Internet in order to share its connection to the Wireless clients. A reboot is needed to allow system services to restart in the correct order (system-resolved isc-dhcp-server hostapd).

### DNS probe URL on the internet
If you encounter difficulties by connecting to the internet through thewifi hotspot, it's because of an incorrect DNS setup.
Run the folloying command on the host machine, it should return a valid dns from your ISP:

   ```systemd-resolve --status```

If you don't know the DNS IP addresses of your ISP, ask your administrator for them or try to resolve them with:

   ```nslookup ns1.your-isp.com ns2.your-isp.com```

Then add them to your home wifi network:

   ```scripts/hap-wiz-bionic.sh 10.0.1.0/24 192.168.1.0/24 eth0 HomeWifiNet OneWPAssword a US 36 80.10.246.2 80.10.246.129```

### Fixed IP address client
Host Access Point's able to define a fixed IP for a specific host. To list the current leases in DHCP service, run dhcp-lease-list :
 ```dhcp-lease-list 
To get manufacturer names please download http://standards.ieee.org/regauth/oui/oui.txt to /usr/local/etc/oui.txt
Reading leases from /var/lib/dhcp/dhcpd.leases
MAC                IP              hostname       valid until         manufacturer        
===============================================================================================
b8:...:f2  10.0.1.37    clientmachine   2018-07-20 13:37:49 -NA-  
```
You can assign a fixed IP to any host with the following script :
 ```scripts/init.d/init_dhcp_serv.sh --leases clientmachine 5```
A few minutes later, *clientmachine* will be permanently fixed to the IP address 10.0.1.5 instead of 10.0.1.37.

# Copyright 2018 www.b23prodtm.info

Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
