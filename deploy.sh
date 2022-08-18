#!/bin/bash

if [ $# -ne 1 ]; then
    echo '引数が１つではないためコミットメッセージをupdateに設定します'
    MSG='update'
    exit 1
else
    MSG=$1
fi
echo $MSG

# ローカルのgitに修正を反映する
echo '------------------------'
echo 'git commit & push'
echo '------------------------'
o
set -x # デバック開始
git add . 
git commit -m "$MSG"
set +x # デバック出力停止 
# mainブランチを指定リポジトリのsrcブランチにpushする
git push -u origin main:src


# # リモートのファイルを一旦削除して
# hexo clean

# hexoをデプロイする
echo '------------------------'
echo 'hexo deploy'
echo '------------------------'
hexo d -g