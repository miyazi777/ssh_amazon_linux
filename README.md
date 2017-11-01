# 概要
AWS EC2(amazon linux)でsshログインして動作するものの動作テスト環境をdockerで構築するテスト。<br>
ansibleやcapistrano,fabricなどの動作テストをローカル環境だけでやりたい場合を想定しています。

## 事前準備

### 公開キーを作成
公開キーを以下のように作ります。
```
ssh-keygen -t rsa -b 4096 -f authorized_keys
```

### Dockerfileとdocker-composeファイルを作成
以下のようなDockerfileとdocker-compose.ymlを容易。<br>
コンテナが１つなのでdocker-compose.ymlは必要ないのですが、どのようにコンテナを起動したかのメモかわりになるので残りしています。<br>
Dockerfileの最後のCMDはtailしてコンテナを終了しないようにする為のものです。<br>


## イメージ作成&&コンテナ作成と起動
以下のコマンドでイメージとコンテナを作成。<br>

```
docker-compose build
docker-compose up -d
```

## sshでのログイン
```
ssh -i authorized_keys user1@localhost -p 2022
```

