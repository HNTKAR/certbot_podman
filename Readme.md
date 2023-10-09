# はじめに
GoogleDomeinを用いてワイルドカード証明書を作成する場合、事前に[こちら](Readme_GoogleDomain.md)を参考に、鍵を生成すること  
Cloudflareを用いてワイルドカード証明書を作成する場合、事前に[こちら](Readme_Cloudflare.md)を参考に、鍵を生成すること  
以下にコンテナの説明や環境の設定を記載
|名称|値|
|:-:|:-:|
|コンテナ名|certbot|
|イメージ名:バージョン|certbot:main|
|証明書を発行するドメイン|sample.example.com|
|証明書を出力するボリューム|certbot_dir|
|証明書のログを出力するボリューム|certbot_log|
|GoogleDomainを用いる場合の鍵ファイル|Config/key.json|
|Cloudflareを用いる場合の鍵ファイル|Config/key.ini|

# 実行スクリプト
```bash
cd certbot_podman

# ボリュームの作成
podman volume create certbot_dir
podman volume create certbot_log

podman build --build-arg KEY_FILE=Config/key.ini --tag certbot:main --file Dockerfile .
podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot certbot:main -d *.kusari.trade
# podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot certbot:main -d *.kusari.trade --dry-run

podman build --build-arg KEY_FILE=Config/key.ini --tag certbot-renew:main --file Dockerfile .
podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot-renew certbot-renew:main
# podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot-renew certbot-renew:main

```

# 自動更新を行う場合
イメージのビルド
```bash
podman build --build-arg KEY_FILE=Config/key.ini --tag certbot-renew:main --file Dockerfile .
```
cronに以下を登録
```bash
0 3 * * * podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot-renew certbot-renew:main
```

## 参考資料
[Google Cloud 公式資料](https://cloud.google.com/apigee/docs/hybrid/v1.8/lets-encrypt.html?hl=ja)
