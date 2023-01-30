# ASI_VMS

## Ubuntu Docs
[Apache](https://ubuntu.com/server/docs/web-servers-apache)

[DNS](https://ubuntu.com/server/docs/service-domain-name-service-dns)

[DNS DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-20-04)

[SSH](https://www.ssh.com/academy/ssh/copy-id#setting-up-public-key-authentication)

[LVM](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/logical_volume_manager_administration/lvm_examples#vol_create_ex)

##### Verificar syntax do bind9
```
sudo named-checkconf
```

##### Na resolução da parte de DNS, desativar o serviço `systemd`
```sh
sudo systemctl stop systemd-resolved
```

OR [Alternative Method](https://user-images.githubusercontent.com/66122667/215534677-7e9be64f-461f-489c-957a-df47dc1b48c6.png)

