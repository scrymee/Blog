#!/bin/bash

# ローカルのgitに修正を反映する
git add . 
git commit -m 'update'

# mainブランチを指定リポジトリのsrcブランチにpushする
git push -u main:src  


# # リモートのファイルを一旦削除して
# hexo clean

# hexoをデプロイする
hexo d -g