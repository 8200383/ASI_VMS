;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	example.com. root.example.com. (
			     22		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
@	IN	NS	ns.example.com.
@	IN	A	192.168.56.26
@	IN	AAAA	::1
ns	IN	A	192.168.56.26
