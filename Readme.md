# はじめに
GoogleDomeinを用いてワイルドカード証明書を作成する場合、事前に[こちら](Readme_GoogleDomain.md)を参考に、鍵を生成すること  
環境は以下の状態を想定する
|名称|値|
|:-:|:-:|
|コンテナ名|certbot|
|イメージ名:バージョン|certbot:1.1|
|証明書を発行するドメイン|sample.example.com|
|証明書を出力するボリューム|certbot_dir|
|証明書のログを出力するボリューム|certbot_log|
|GoogleDomainを用いる場合の鍵ファイル|Config/key.json|

# 実行スクリプト
```bash
cd certbot_podman

# イメージのビルド
# podman build --build-arg DRY_RUN_FLAG=true --build-arg DOMAIN="sample.example.com" --build-arg KEY_FILE=Config/key.json --tag certbot-dry:1.1 --file Dockerfile .
podman build --build-arg DOMAIN="sample.example.com" --build-arg KEY_FILE=Config/key.json --tag certbot:1.1 --file Dockerfile .

# ボリュームの作成
podman volume create certbot_dir
podman volume create certbot_log

# コンテナの実行
# podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot-dry certbot-dry:1.1
podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot certbot:1.1
```

# 自動更新を行う場合
cronに以下を登録
```bash
podman run --detach --replace --mount type=volume,source=certbot_dir,destination=/etc/letsencrypt --mount type=volume,source=certbot_log,destination=/var/log/letsencrypt --name certbot-renew certbot-renew:1.1
```

## 参考資料
[Google Cloud 公式資料](https://cloud.google.com/apigee/docs/hybrid/v1.8/lets-encrypt.html?hl=ja)
