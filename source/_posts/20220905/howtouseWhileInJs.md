---
categories:
  - programming
tags:
  - [Javascript]
date: 2022-09-05 09:29:20
title: Javascriptで「特定の要素が出るまでtryする」のためにWhileを使う
---

<!-- toc -->

<!-- more -->

## whileに怯えない

JSに限らず、上記の場合はWhileを使用すると良い。
なんとなく、**whileは無限ループを引き起こしうる**と聞いたことがあり、感覚的にも理解できるのだが、場合によっては使われているケースもある。
検索系だと、こんなケースもあった。

```php
while(true) {
  //ループ処理や加工などを繰り返した後に
  if($connect) {
    return $connect;
  }

  $retryCount++;

  if($item === null) {
    $this->getItem();
    echo "${$retryCount}回のリトライ";
    break;
  }
}
```

必ずブレイクするような処理で抜けるように指定してあげると良い
ただ、本当にループの終了漏れがないか確認することは肝心だが、、、

要するに、`while (true)`といった一見すると危険そうに見える処理も実際に使用されているため、使い方に注意するのは当然ではあるが、そこまで怯えなくて良さそう

## Jsのwhileの使い方

たとえば、ランダム文字列を抽出するが、それが重複しないようにユニークな値とする場合

```js
let y, x
do {
  y = Math.tranc(Math.random() * 10);
  x = Math.tranc(Math.random() * 10);
} while (!board[y][x])

board[y][x] = true;
```

特定の座標にランダムにデータを入れる場合の処理。
上記のコマンドは、whileの中がtrueになるまで続ける処理だ。

上記の場合は、`do内は必ず1回は実行される`そして、`!board[y][x]`がtrueつまり、値が入っていない状態になるまで設定し続けるのだ。

ちなみに、while内の変数はdo外にでも指定しておかなればエラーになるので注意。

他にも下記のように書いてあげると、上とは逆になる。
つまり、whileの中がfalseになるまで続けられる


```js

getData = false

while (dataCount < 5) {

  if(hasData) {
    dataCount++;
  }
}

```


**trueになるまで続ける場合は、`do while` falseになるまで続けるのは通常の`while`**なのを覚えておこうね