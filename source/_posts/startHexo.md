---
title: Hexoで簡単に公開する
date: 2022-08-16 23:26:36
tags: - [hexo]
---

## 要するに

1. Hexoというライブラリを使用する
2. Github Pageを使用する

Hexoは、Markdownをもとに静的テキストデータを出力する。
GithubPageは静的ページを良い感じに展開してくれるGitHubの機能。この２つを使用する。

## 事前準備

hexoを使用するためにはいくつかのライブラリが必要になるので、未インストールの場合はインストールする。これがある場合は割愛してよい。

### node.jsとnpm

`node -v`で確認できる。`command not found`が出力された場合インストールする。

Homebrewを使用してもインストールできるようだが、今回は公式サイトのインストーラーを使用する。

[Node.js](https://nodejs.org/ja/)

公式サイトでダウンロードしたファイルを起動して案内に従いインストールする。

インストールされているか確認のためにversionを出力してみる

```shell
$ node -v
v16.17.0
```

同じように、node.jsをインストールしたときに、npmというパッケージ管理ツールもインストールされるので確認しておく。
npmによって、いくつものライブラリを簡単にインストールすることができるようになる。

```shell
$ npm -v
8.15.0
```

良い感じ。

### hexo

今回はMarkdownをいい感じに出力してくれるhexoを使用する。その雛形をいい感じに作成してくれるhexoのコマンドをローカルでも使用できるようにする。

余談だが、markdownはpandocなどを使用することでPDFやWordでの出力も可能であるし、PPT風の発表資料の作成もできる。markdown便利。

閑話休題。引き続きhexoをインストールする。

`sudo npm install hexo-cli -g`

インストールが完了したら下記のコマンドでインストールされたか確認する

```shell
$ hexo -v
hexo-cli: 4.3.0
os: darwin 20.6.0 11.6.4

node: 16.17.0
...
```

## Hexoのアプリケーションディレクトリ作成

事前準備が終わったら、Hexoによってブログの雛形を作成する。アプリケーションを作成したいディレクトリに移動して、下記コマンドを実行する

`hexo init [アプリ名]`

```shell
$ hexo init hexo
INFO  Cloning hexo-starter https://github.com/hexojs/hexo-starter.git
INFO  Install dependencies
INFO  Start blogging with Hexo!
```

アプリケーションディレクトリにアクセスすると、諸々のファイルが作成されている

```shell
$ cd hexo
$ ls -1
_config.landscape.yml
_config.yml
node_modules
package-lock.json
package.json
scaffolds
source
themes
```

これで一旦完了。実際のブログを確認してみる。

### Hexoで作成したブログの確認

Hexoで作成したアプリケーションディレクトリに移動して、`hexo server`で起動できる。`hexo s`でも良い。

```shell
$ cd hexo
$ hexo server
INFO  Validating config
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/ . Press Ctrl+C to stop.
```

これで、実行時記載のURLにアクセスすると、ブログの画面が確認できる。

### TOPページが記載されているmdファイルの確認

下記で確認可能。アプリケーションディレクトリの`source/_post/hello-world.md`に存在している。そのためこの中身を書き換えることで、記事の中身も変更できる。

```shell
$ cd hexo
$ cd source
$ cd source/_post
$ ls -1
hello-world.md
```

## 記事を追加する

記事は、`hexo new [mdファイル名]`で作成ができる。これも`hexo n [mdファイル名]`でも良い。

```shell
$ hexo n 'startHexo'
INFO  Validating config
INFO  Created: ~/workspace/hexo/source/_posts/startHexo.md
```

これで、`source/_post`ディレクトリ内にmdファイルが作成される

```shell
% ls -1
hello-world.md
startHexo.md
```

余談だが、詳しいコマンドは、`hexo --help`から確認できる。

```shell
$ hexo --help
INFO  Validating config
Usage: hexo <command>

Commands:
  clean     Remove generated files and cache.
  config    Get or set configurations.
  deploy    Deploy your website.
  generate  Generate static files.
  help      Get help on a command.
  init      Create a new Hexo folder.
  list      List the information of the site
  migrate   Migrate your site from other system to Hexo.
  new       Create a new post.

  ...
```

## hexoで投稿した記事の確認

`hexo s`で起動したときにmdファイルを追記しただけではlocalhostで確認できる。

