---
title: Hexoをローカル環境で構築する
date:   2021/12/28 12:00:00
categories:
    - プログラミング
tags:
    - 環境構築 
---


HexoはNode.jsの静的サイトジェネレーターツールの名称である。静的サイトのため、**データベースなどは不要**な点が特徴。加えて、**Markdownで記事を作成**するため、サービスに依存しない。作成した記事は、Serverを起動することで確認できるが、コマンドによってHTML形式で静的サイトに変換できる。


## Hexoのインストール方法

### Node.jsへHexoのインストール

Node.jsの実行環境は構築済みとする。DockerでNode.jsのイメージを使用した。

```bash
npm install -g hexo
```

### Hexoの雛形作成

下記コマンドでひな形ファイルを作成できる。
※APPはプロジェクトの名前

```bash
hexo init APP
```

その結果、下記のようなディレクトリ構成で作成される

```tree
├─ .github
├─ node_modules
├─ scaffolds
├─ source
|   └─ post.md
|      
├─ themes
|    └─ landscape
├─ _config.yml

```

## Localでの確認方法

下記コマンドで実行可能

```bash
hexo server
```

## themesの変更

下記サイトからHexoのテーマを選択できる。
[Themes | Hexo](https://hexo.io/themes/)

こちらからgithubのページへアクセスできる。そこから該当テーマのディレクトリをダウンロードする。（**Download ZIP** または `git clone XXX`)
ダウンロードしたファイルは、themesファイル内に配置する。（`hexo init`のときにはlandscapeディレクトリが配置されている）

その後、`_config.yml`にて記載されているthemeをthemesファイル内にあるテーマのディレクトリ名へと変更する

## テーマについて

Hexoのicarusは下記が作者のサイトになっている
[如何给 Icarus 增加夜间模式 - iMaeGoo's Blog](https://www.imaegoo.com/2019/icarus-night-mode-2/)

また、themesによっては別のライブラリをインストールする必要がある。
たとえば、icarusを適用した場合下記のようなライブラリをインストールするコマンドを実行する。

これらのコマンドは、`hexo server`実行時のエラーで案内される。

```bash
npm install --save bulma-stylus@0.8.0 hexo-renderer-inferno@^0.1.3 hexo-component-inferno@^0.14.0 inferno@^7.3.3 inferno-create-element@^7.3.3
```

## おわりに

icarusはダークモード（night mode）を実装できる点と見た目のスマートさから導入した。見た目も良いね。