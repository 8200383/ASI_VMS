# ASI_VMS

## Ubuntu Docs
[Apache](https://ubuntu.com/server/docs/web-servers-apache)

[DNS](https://ubuntu.com/server/docs/service-domain-name-service-dns)

[SSH](https://www.ssh.com/academy/ssh/copy-id#setting-up-public-key-authentication)

##### Verificar syntax do bind9
```
sudo named-checkconf
```

##### Na resolução da parte de DNS, desativar o serviço `systemd`
```sh
sudo systemctl stop systemd-resolved
```

OR [Alternative Method](https://user-images.githubusercontent.com/66122667/215534677-7e9be64f-461f-489c-957a-df47dc1b48c6.png)

