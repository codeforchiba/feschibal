# matsuri

[Code for Chiba](http://code4chiba.org) の feschibalプロジェクトのソースコードです。

## 使用ライブラリ

主に以下のライブラリを使用して作られています。

- jquery
- bootstrap
- leaflet
- riotjs

## 開発ツール

本プロジェクトでは開発ツールとしてGruntを使用しています。
Gruntが担うタスクは以下の機能になります。

- scssのコンパイル
- tagファイルのコンパイル
- 開発用httpサーバの起動
- リリース用モジュール（ソース圧縮、結合等）の生成

### 開発ツールのインストール

1. [node](https://nodejs.org/)のインストール（nodeが既にインストールされている場合はスキップ可）

※注　macの場合nodeが/usr/local下にインストールされると権限の問題でnpmコマンドが失敗します。    
　　　インストール先を変更するか、権限を与えるようにしてください。

2. gruntのインストール

```
$ npm install -g grunt-cli
```

## 開発環境準備

1. ソースをチェックアウトし、プロジェクトのディレクトリに移動する

```
$ git clone https://github.com/codeforchiba/feschibal.git
$ cd feschibal
```

2. プロジェクトのルートディレクトリで以下のコマンドを実行し、必要なモジュールのセットアップ

```
$ npm install
```

## ローカル環境で実行する

```
$ grunt serve
```

以下の URL で動作確認できます。

    http://localhost:9000/
    
### ローカル環境で開発する

"grunt serve" で、サーバを起動している最中はscssファイルもtagファイルも変更を自動で検知し、自動でコンパイルしてくれます。

## その他Gruntのタスク

#### リリースモジュールの生成

```
$ grunt build
```

#### リリースモジュールでの動作確認

```
$ grunt serve:dist
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

