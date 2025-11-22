# はじめに
GoogleDomeinを用いてワイルドカード証明書を作成する場合、事前に[こちら](https://cloud.google.com/apigee/docs/hybrid/latest/lets-encrypt?hl=ja)を参考に、鍵を生成すること  
Cloudflareを用いてワイルドカード証明書を作成する場合、事前に[こちら](https://certbot-dns-cloudflare.readthedocs.io/en/stable/)を参考に、鍵を生成すること  
以下にコンテナの説明や環境の設定を記載
# 全体設定
|名称|値|
|:-:|:-:|
|コンテナ名|certbot|
|イメージ名:タグ名|certbot:latest|
|証明書を発行するドメイン|sample.example.com,*.example.com|
|証明書を出力するボリューム|certbot-volume|
|鍵ファイル|certbot_key|

# certbot
## Quadle使用時
```bash
cd certbot_podman

# 認証キーを設定
podman secret create certbot_key _key

# 必要に応じて Quadret/certbot.container を書き換える
mkdir -p $HOME/.config/containers/systemd/
cp Quadlet/* $HOME/.config/containers/systemd/
systemctl --user daemon-reload

# イメージのビルド
systemctl --user start podman_build_certbot.service
# コンテナ起動
systemctl --user start podman_container_certbot.service
```
### 自動実行を行う場合

cronに以下を登録
```bash
0 3 * * * systemctl --user restart podman_container_certbot.service
```

## Quadlet非使用時
```bash
cd certbot_podman

# イメージのビルド
podman build --tag certbot --file Dockerfile .

# コンテナの実行
DOMAIN="-d sample.example.com -d *.example.com"
podman run --detach --replace --mount type=volume,source=certbot-volume,destination=/V ---mount type=volume,source=certificate,destination=/etc/letsencrypt -env="DOMAIN=$DOMAIN" --secret certbot_key --name certbot certbot
```

### 自動更新を行う場合
cronに以下を登録
```sh
0 3 * * * DOMAIN="-d sample.example.com -d *.example.com" podman run --detach --replace --mount type=volume,source=certbot-volume,destination=/V ---mount type=volume,source=certificate,destination=/etc/letsencrypt --env="DOMAIN=$DOMAIN" --secret certbot_key --name certbot certbot
```
