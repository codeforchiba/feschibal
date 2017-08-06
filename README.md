# Feschibal

[Code for Chiba](http://code4chiba.org) のお祭りデータセンターのソースコードです。

![Circle CI Build Status](https://circleci.com/gh/codeforchiba/feschibal/tree/master.svg?style=shield&circle-token=55757713b71498526946dbfceaf48a286a776a90)
[![Stories in ToDo](https://badge.waffle.io/codeforchiba/feschibal.svg?label=todo&title=ToDo)](http://waffle.io/codeforchiba/feschibal)

## 使用ライブラリ

主に以下のライブラリを使用して作られています。

- jquery
- bootstrap
- leaflet
- riotjs

## 開発ツール

本プロジェクトでは開発ツールとしてDockerとGruntを使用しています。
DockerではGruntを動かす為のnodeやnpmの環境を提供しています。
Gruntが担うタスクは以下の機能になります。

- scssのコンパイル
- tagファイルのコンパイル
- 開発用httpサーバの起動
- リリース用モジュール（ソース圧縮、結合等）の生成

## Dockerを用いた開発環境
(以下、Docker環境)
### 開発ツールのインストール
- [Docker](https://www.docker.com/products/overview)をインストール

### 開発環境準備
ソースをチェックアウトし、プロジェクトのディレクトリに移動します。

```
$ git clone https://github.com/codeforchiba/feschibal.git
$ cd feschibal
```
### 開発環境で実行する
#### 1. DockerImageを用意する

- DockerHubから取得する場合
```
$ docker pull codeforchiba/feschibal
$ docker tag codeforchiba/feschibal festival-server-dev
```

- 自分でビルドする場合
```
$ docker build -t festival-server-dev -f Dockerfile.dev .
```

#### 2. Dockerコンテナを起動する
- 取得したDockerImageをDockerコンテナとして起動
```
$ docker run -d -p 9000:9000 -p 35729:35729 -v $(pwd)/app:/var/www/feschibal/app festival-server-dev
```

以下の URL で動作確認できます。
```
http://localhost:9000/
```

## ローカル環境で開発する
プロジェクトのディレクトリ配下でファイルを編集します。

ファイルを更新すると、開発環境を起動している間はscssファイルもtagファイルも変更を自動で検知し
自動でコンパイルしてくれます。
また、livereload-jsがブラウザを自動でリロードしてくれます。

## node.jsを用いた開発環境
ローカル環境にnode.jsをインストールして開発環境を作ります。
### 開発ツールのインストール
- [node](https://nodejs.org/en/)のインストール

**（nodeが既にインストールされている場合はスキップ可）**

※注　macの場合nodeが/usr/local下にインストールされると権限の問題でnpmコマンドが失敗します。
インストール先を変更するか、権限を与えるようにしてください。

### 開発環境準備
- npmとgruntをアップデートする

```
$ npm install -g npm
$ npm install -g grunt-cli
```

### 開発環境で実行する
#### 1. 必要なモジュールのセットアップ
プロジェクトのディレクトリ直下で実行してください。
```
$ npm install
```

#### 2. 開発環境を起動する

- 開発用サーバーを起動する場合
```
$ grunt serve
```

- expressサーバーを起動する場合
```
$ grunt serve:express
```

以下の URL で動作確認できます。
```
http://localhost:9000/
```

### ビルド
サーバに設置するためのファイルをdist配下に生成します。

オプションを指定しないと`config/default.yml`を使ってbuildします。

#### ステージング
`config/staging.yml`を使ってbuildします。
```
grunt build:staging
```

#### 本番
`config/production.yml`を使ってbuildします。
```
grunt build:production
```

## ディレクトリ構造

### app

アプリケーションソースの配置場所

### .tmp

Gruntによって自動生成されたファイル（css, js）が配置される場所。
scssから生成されたcssファイル。tagファイルから生成されたjsファイルが配置されています。
ソースのコミット対象外としています。

### dist

"grunt build" で生成された本番用モジュールが配置されます。
ソースのコミット対象外としています。

### node_modules

開発ツールであるGruntに関連するファイルが配置されています。
"npm install" をすることで必要なモジュールがこのディレクトリの下に配置されます。
ソースのコミット対象外としています。

## ライセンス

MIT
