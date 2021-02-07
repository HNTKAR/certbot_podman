# ssl certificate issuance Container

## **設定ファイル**

```
###ssl###
domain:example.com
domain:example.org,example.net
```

## **コンテナの起動**
```
sudo firewall-cmd --add-forward-port=port=80:proto=tcp:toport=10080 --permanent
sudo firewall-cmd --reload
sudo mkdir -p -m 777 /home/podman/ssl_pod/letsencrypt /home/podman/ssl_pod/log
./script.sh
podman pod create --replace=true -p 10080:80 -n ssl_pod --net slirp4netns:port_handler=slirp4netns
podman run --replace=true -td --pod ssl_pod -v /home/podman/ssl_pod/letsencrypt:/etc/letsencrypt -v /home/podman/ssl_pod/log:/log --name certbot certbot
```

## **ファイルおよびフォルダ**
 certbot  
> * /home/podman/ssl_pod/letsencrypt/live/example/
>> 発行された各種証明書  
> 
> * /home/podman/ssl_pod/log/  
>> 証明書発行時のログ  

### 自動起動の設定
```
mkdir -p $HOME/.config/systemd/user/
podman generate systemd -f -n --new --restart-policy=always ssl_pod >tmp.service
systemctl --user start pod-ssl_pod
cat tmp.service | \
xargs -I {} \cp {} -frp $HOME/.config/systemd/user
cat tmp.service | \
xargs -I {} systemctl --user enable {}
```

### 自動起動解除
```
cat tmp.service | \
xargs -I {} systemctl --user disable {}
```

