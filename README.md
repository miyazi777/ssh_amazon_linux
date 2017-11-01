# 概要
AWS EC2(amazon linux)でsshログインして動作するものの動作テスト環境をdockerで構築するテスト。<br>
ansibleやcapistrano,fabricなどの動作テストをローカル環境だけでやりたい場合を想定しています。

## 事前準備

### 公開キーを作成
公開キーを以下のように作ります。
```
ssh-keygen -t rsa -b 4096 -C "m71203@gmail.com" -f authorized_keys
```

### Dockerfileとdocker-composeファイルを作成
以下のようなDockerfileとdocker-compose.ymlを容易。<br>
コンテナが１つなのでdocker-compose.ymlは必要ないのですが、どのようにコンテナを起動したかのメモかわりになるので残りしています。<br>
Dockerfileの最後のCMDはtailしてコンテナを終了しないようにする為のものです。<br>

```Dockerfile
FROM amazonlinux:latest

ARG USER

RUN yum -y update && yum -y install openssh-server && yum -y install sudo
RUN adduser $USER && mkdir -p /home/$USER/.ssh && chown $USER:$USER /home/$USER/.ssh && chmod 0700 /home/$USER/.ssh
ADD ./authorized_keys.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys && chmod 0600 /home/$USER/.ssh/authorized_keys
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

CMD /etc/init.d/sshd start && tail -f /dev/null
```

```docker-compose.yml
version: '2'
services:
    app:
        build:
            context: .
            args:
                USER: user1
        container_name: al_test
        stdin_open: true
        tty: true
        ports:
            - "2022:22"
        volumes:
            - .:/share
```

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

