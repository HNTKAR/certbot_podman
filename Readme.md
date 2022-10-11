# はじめに
環境は以下の状態を想定する
|名称|値|
|:-:|:-:|
|コンテナ名|certbot|
|イメージ名:バージョン|certbot:1.0|
|証明書を発行するドメイン|sample.example.com|
|証明書を出力するボリューム|cert-dir|

# 実行スクリプト
```bash
cd certbot_podman

# イメージのビルド
podman build --build-arg --build-arg DOMAIN="sample.example.com" --build-arg KEY_FILE=Config/key.json --tag certbot:1.0 --file Dockerfile .
# podman build --build-arg DRY_RUN_FLAG=true --build-arg DOMAIN="sample.example.com" --build-arg KEY_FILE=Config/key.json --tag certbot-dry:1.0 --file Dockerfile .

# ボリュームの作成
podman volume create cert-dir
# コンテナの実行
podman run --detach --replace --name certbot certbot:1.0
podman run --detach --replace --mount type=volume,source=cert-dir,destination=/etc/letsencrypt --name certbot certbot:1.0
```