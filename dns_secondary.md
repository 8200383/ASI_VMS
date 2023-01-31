# Secondary DNS Server using Bind9

## Specifications

Domain: `epnormal.asi`

Machine NS1: `192.168.56.20`

Machine NS2: `192.168.56.30`

Network: `192.168.56.0/24`

## Configure DNS clients
```sh
nameserver 192.168.56.20 # For both NS1 and NS2
search epnormal.asi
```

## Register NS2 on NS1
```sh
sudo vim /etc/bind/named.conf.options

acl "trusted" {
        192.168.56.20; # ns1
        192.168.56.30; # ns2
};

OR

acl "trusted" {
  192.168.56.0/24; # Any IP on the network
};

```

## Validate your changes
```sh
sudo named-checkconf
```

## Register both DNS Servers on NS2
```sh
sudo vim /etc/bind/named.conf.options

acl "trusted" {
        192.168.56.20; # ns1
        192.168.56.30; # ns2
};

OR

acl "trusted" {
        192.168.56.0/24;
};

options {
        recursion yes;
        allow-recursion { trusted; };
        listen-on { 192.168.56.30; };      # ns2 private IP address
        allow-transfer { none; };          # disable zone transfers by default

        forwarders {
                8.8.8.8;
                8.8.4.4;
        };
};
```

## Validate your changes
```sh
sudo named-checkconf
```

## Create the second Zone
```sh
sudo vim /etc/bind/named.conf.local

zone "epnormal.asi" {
    type slave;
    file "/var/cache/bind/epnormal.asi.zone";
    masters { 192.168.56.20; };  # ns1 private IP
};
```

## Check the validity of your configuration files
```
sudo named-checkconf
sudo systemctl restart bind9
```

## Test your configs
```sh
# On NS2
dig ns1.epnormal.asi
dig ns2.epnormal.asi

# On NS2
dig ns1.epnormal.asi
dig ns2.epnormal.asi
```
