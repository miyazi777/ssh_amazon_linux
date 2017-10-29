# 概要
AWS EC2などでsshログインして動作するものの動作テスト環境をdockerに構築するテスト。<br>
ansibleやcapistrano,fabricなどの動作テストを想定。

## 事前準備
公開キーを以下のように作成する
```
ssh-keygen -t rsa -b 4096 -C "m71203@gmail.com" -f authorized_keys
```

## イメージ作成&&コンテナ作成と起動
```
docker-compose build
docker-compose up -d
```

## sshでのログイン
```
ssh -i authorized_keys testuser@localhost -p 2022
```

