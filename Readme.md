# はじめに
GoogleDomeinを用いてワイルドカード証明書を作成する場合、事前に[こちら](https://cloud.google.com/apigee/docs/hybrid/latest/lets-encrypt?hl=ja)を参考に、鍵を生成すること  
Cloudflareを用いてワイルドカード証明書を作成する場合、事前に[こちら](https://certbot-dns-cloudflare.readthedocs.io/en/stable/)を参考に、鍵を生成すること  
以下にコンテナの説明や環境の設定を記載
|名称|値|
|:-:|:-:|
|コンテナ名|certbot|
|イメージ名:タグ名|certbot:main|
|証明書を発行するドメイン|sample.example.com,test.example.com|
|証明書を出力するボリューム|certbot|
|鍵ファイル|certbot_podman/_key|

# 実行スクリプト
```bash
cd certbot_podman

# ドメインの設定(ドメインごとに -d が必要)
DOMAIN="-d sample.example.com -d test.example.com"

# イメージのビルド
podman build --build-arg KEY_FILE=_key --tag certbot --file Dockerfile

# コンテナの実行
podman run --detach --replace --mount type=volume,source=certbot,destination=/etc/letsencrypt --name certbot certbot $DOMAIN --keep-until-expiring

# テストする場合は以下を実行
# podman run --detach --replace --mount type=volume,source=certbot,destination=/etc/letsencrypt --name certbot certbot $DOMAIN --dry-run
```

# 自動更新を行う場合
cronに以下を登録
```bash
0 3 * * * TagName="main" DOMAIN="-d sample.example.com -d test.example.com" && podman run --detach --replace --mount type=volume,source=certbot,destination=/etc/letsencrypt --name certbot certbot $DOMAIN --keep-until-expiring && unset TagName DOMAIN
```
