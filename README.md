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
podman pod create -p 1080:80 -n certbot_pod
podman run -dt --pod certbot_pod --name certbot certbot
```

