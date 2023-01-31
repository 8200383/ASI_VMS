# Bind9 Primary DNS Configuration

## Help Docs
[BIND9ServerHowto](https://help.ubuntu.com/community/BIND9ServerHowto#Primary_Master_Server)

[RHEL Bind9](https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/8/html/dns-as-a-service_guide/install_and_configure_bind9)

[Digital Ocean Bind9](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-20-04)

## Specifications
Domain: `epnormal.asi`

Machine: `192.168.56.20`

Network: `192.168.56.0/24`

## Warnings
`named-checkconf`: Checks the syntax, It does not check the semantics of your cheat code!

## Do not disabled unless is your last resource 
```sh
sudo vim /etc/systemd/resolved.conf
DNSStubListener=no # Turn this off

sudo systemctl restart systemd-resolved
```
## Install Bind9
```sh
apt-get install bind9
```

## Configuring the Options File
```sh
vim /etc/bind/named.conf.options
acl "trusted" {
  192.168.56.0/24; # Any IP on the network
};

options {
   recursion yes;
   listen-on { 192.168.56.20; }; # IP Addr from the Primary DNS machine
   allow-recursion { trusted; };
   allow-transfer { none; };
   empty-zones-enable no;
};
```

```sh
# If no output is sent it means everything is OK
named-checkconf /etc/bind/named.conf.options
```

## Create Zone
```sh
vim /etc/bind/named.conf.local

zone "epnormal.asi" IN {
  type master;
  file "/etc/bind/epnormal.asi.zone";
};
```

## Validate Zone Configuration
```sh
named-checkconf /etc/bind/named.conf.local
```

## Configure ASI Zone
```sh
cp /etc/bind/db.local /etc/bind/epnormal.asi.zone
```

```sh
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     epnormal.asi. root.epnormal.asi. (
                              6         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; Define the default name server to ns1.epnormal.asi
@       IN      NS      ns1.epnormal.asi.
; Resolve ns1 to server IP Addr
ns1     IN      A       192.168.56.20
; Other domains to epnormal.asi
impressora1     IN      A       192.168.56.21
sap     IN      A       192.168.56.22
crm     IN      CNAME   sap
```

## Check & Reload Bind9
Increment `; Serial` if you restart bind9

```sh
sudo named-checkconf

sudo named-checkzone epnormal.asi /etc/bind/epnormal.asi.zone 
zone epnormal.asi/IN: loaded serial 6
OK

sudo systemctl restart bind9
```

## Contact your own DNS
```sh
dig @192.168.56.20 epnormal.asi
dig @192.168.56.20 ns1.epnormal.asi
dig @192.168.56.20 impressora1.epnormal.asi
dig @192.168.56.20 sap.epnormal.asi
dig @192.168.56.20 crm.epnormal.asi
```

