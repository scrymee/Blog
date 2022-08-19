---
title: hexoをGithubにデプロイする
categories:
  - programming
tags:
  - [hexo]
date: 2022-08-17 12:46:30
---


<!-- toc -->

## Summary

- Hexoをデプロイする
- 

<!-- more -->

## deploy用のライブラリインストール

`npm install hexo-deployer-git --save`

gitをhexoコマンドで使用するためのパッケージをインストールする

## hexoをデプロイする準備

hexoにはgithubにデプロイ用のコマンドがあるので、それを使う
どのリポジトリにアップロードするかを設定する。

`_config.yml`で<更新＞の箇所を修正する

```yml
# URL
## Set your site url here. For example, if you use GitHub Page, set url as 'https://username.github.io/project'
url: http://example.com # <更新>

# Deployment
## Docs: https://hexo.io/docs/one-command-deployment
deploy:
  type: git # <更新>
  repo: https://github.com/{username}/{username}.github.io # <更新>
  branch: main # <更新>

```

リポジトリのreposは、HTTPSで指定されているもの

## デプロイ

`hexo deploy`で可能。`hexo deploy -g`とオプションを追記することで、静的ファイルの生成も同時に行う

また上記ライブラリをインストールしていないと下記のようなエラーが出るので

```sh
ERROR Deployer not found: git
```


```sh
NFO  Validating config
INFO  Start processing
INFO  Files loaded in 49 ms
INFO  0 files generated in 20 ms
INFO  Deploying: git
INFO  Setting up Git deployment...
Initialized empty Git repository in hexo/.deploy_git/.git/
[main (root-commit) 93eef4a] First commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 placeholder
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
INFO  Copying files from extend dirs...
[main 906c1c0] Site updated: 2022-08-17 13:07:00
 21 files changed, 6278 insertions(+)
 create mode 100644 2022/08/16/hello-world/index.html
 create mode 100644 2022/08/16/startHexo/index.html
 create mode 100644 2022/08/17/uploadHexo/index.html
 create mode 100644 archives/2022/08/index.html
 create mode 100644 archives/2022/index.html
 create mode 100644 archives/index.html
 create mode 100644 css/fonts/FontAwesome.otf
 create mode 100644 css/fonts/fontawesome-webfont.eot
 create mode 100644 css/fonts/fontawesome-webfont.svg
 create mode 100644 css/fonts/fontawesome-webfont.ttf
 create mode 100644 css/fonts/fontawesome-webfont.woff
 create mode 100644 css/fonts/fontawesome-webfont.woff2
 create mode 100644 css/images/banner.jpg
 create mode 100644 css/style.css
 create mode 100644 fancybox/jquery.fancybox.min.css
 create mode 100644 fancybox/jquery.fancybox.min.js
 create mode 100644 index.html
 create mode 100644 js/jquery-3.4.1.min.js
 create mode 100644 js/script.js
 delete mode 100644 placeholder
 create mode 100644 tags/hexo/index.html
Enumerating objects: 42, done.
Counting objects: 100% (42/42), done.
Delta compression using up to 8 threads
Compressing objects: 100% (31/31), done.
Writing objects: 100% (42/42), 887.64 KiB | 15.04 MiB/s, done.
Total 42 (delta 6), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (6/6), done.
To https://github.com/hoge/fuga.github.io.git
 * [new branch]      HEAD -> main
Branch 'main' set up to track remote branch 'main' from 'https://github.com/scrymee/scrymee.github.io.git'.
INFO  Deploy done: git
```

完了する。githubのリポジトリにアクセスすると確認できる。

## 参考文献

[Git Pages & Hexoで手軽な無料Blogを作る - Qiita](https://qiita.com/genie-oh/items/8c19668c7dae6b4a153e)