#!/bin/bash

if [ $# -lt 1 ]; then
    echo '引数が１より少ないためコミットメッセージをupdateに設定します'
    MSG='update'
else
    MSG=$*
fi

# ローカルのgitに修正を反映する
echo '------------------------'
echo 'git commit & push'
echo '------------------------'
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