# ssl Container

## _setting file format_

```
###ssl###
domain:example.com
domain:example.org,example.net
```

## _up container_

```
sudo mkdir -p -m 777 /home/podman/ssl_pod/letsencrypt /home/podman/ssl_pod/log
./script.sh
sudo firewall-cmd --add-forward-port=port=80:proto=tcp:toport=1080 --permanent
sudo firewall-cmd --reload
podman pod create --replace=true -p 1080:80 -n ssl_pod
podman run -td --pod ssl_pod -v /home/podman/ssl_pod/letsencrypt:/etc/letsencrypt -v /home/podman/ssl_pod/log:/var/log --name certbot certbot
#podman exec -it certbot bash
```

