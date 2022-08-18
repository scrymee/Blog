#!/bin/bash

if [ $# -ne 1 ]; then
    echo 'コミットメッセージをupdateに設定します'
    MSG='update'
    exit 1
else
    MSG=$1
fi
echo $MSG

# ローカルのgitに修正を反映する
git add . 
git commit -m "$MSG"
# mainブランチを指定リポジトリのsrcブランチにpushする
git push -u origin main:src


# # リモートのファイルを一旦削除して
# hexo clean

# hexoをデプロイする
hexo d -g