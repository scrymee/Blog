---
title: vscodeの拡張機能のPasteImageを導入する
categories:
  - programming
tags:
  - [vscode]
  - [expansion]
date: 2022-08-18 00:03:04
---

## Summary

- vscodeの拡張機能「Paste Image」を導入しよう
- 導入して使いやすいように、`setting.json`を編集しよう。

## Paste Image。とは

VsCodeの拡張機能で、画像キャプチャしたデータをmdファイルに貼り付けられる機能
markdownで貼り付けた際は、指定したディレクトリに画像ファイルを自動で保存してくれる。

## Paste Imageのインストール

vscodeの拡張機能で下記をインストールする。

[Paste Image - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image)


## PasteImageの設定

`setting.json`にPasteImageの設定を追記する。下記をそのままコピペするといい。
これはmarkdownを貼り付けた際に、どういう形式で保存するかを記載している

```json

    "pasteImage.defaultName": "Y-MM-DD-HH-mm-ss",
    "pasteImage.insertPattern": "![](${imageFilePath})",
    "pasteImage.path": "${projectRoot}/source/images/${currentFileNameWithoutExt}",
    "pasteImage.basePath": "${projectRoot}/source",
    "pasteImage.forceUnixStyleSeparator": true,
    "pasteImage.prefix": "/"
```

`${projectRoot}`は、VScodeで開いているワークスペースのディレクトリパスとなる。

## 使用方法

クリップボードにコピーした画像を、貼り付けてあげると良い。
貼り付ける際は、`shift + command + P`で表示されるコマンド欄に、`paste image`と入力してそれを選択してあげると貼り付けられる。

このとき、このコマンドに対してショートカットキーを設定することもできるので設定するとよいだろう。

僕のPCはMacなので、
`shift + command + ctrl + 4`でクリップボードにコピーし
`shift + command + ctrl + V`でクリップボードからmdにペーストできるようにしている


## 参考文献

[Hexo によるブログ執筆環境の構築 | /etc/openjny](https://openjny.github.io/posts/2019/02/24/hexo-blog/)
[GitHub+VSCodeでのMarkdownドキュメンテーションのプロジェクトルールを考える](https://zenn.dev/ttani/articles/github-vscode-documentation-rule)


<!-- more -->

