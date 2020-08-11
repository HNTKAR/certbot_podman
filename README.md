# certbot Container

### _setting file format_

```
###certbot###
domain:example.com
domain:example.org,example.net
```

### _up container_
```
./script.sh
sudo firewall-cmd --add-forward-port=port=80:proto=tcp:toport=1080
podman pod create -p 1080:80 -n test
podman run -dt --pod test --name test1 certbot
```

