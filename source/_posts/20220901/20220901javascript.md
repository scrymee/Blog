---
categories:
  - programming
tags:
  - [javascript]
  - [非同期処理]
date: 2022-09-01 23:06:36
title: 非同期処理のPromiseとasyncとawaitの使い方
---

<!-- toc -->

<!-- more -->

## 画面描写を人間に違和感なく表現するAjax

業務中に「この取得処理は重いからajaxで非同期処理で実装しよう」というケースが有った。
イメージとしては、ユーザーが登録している欲しい物リストを10件抽出し、TOPページに表示するという内容に近い。

要するに、TOPページの描写と並行して、非同期処理で負荷のかかるロジックを実現することで、負荷のかかる処理を終えることなくそれ以外の画面を描写しておくことでユーザビリティを上げようとした。

それ自体は、Ajaxを使えば問題なく実装できるのだけど、Ajaxとjsとの組み合わせは実行順序の観点から注意すべき点がある

## 非同期処理は実行順序を保証しない

非同期処理の概念を知っていると当然だが、非同期処理は実行順序が上から行うことを保証しない。

そしてjavascriptでありがちな、特定の要素をクリックすると何かしらの処理を行うようなクリックイベントの登録もこの影響を受ける

つまり下記のようにAjaxの処理でHTMLを画面上に付与する場合、`<button id="btn">`がajaxで表示される前に、`const btn = ...`が実行されるため、`btn`変数の中はnullになってしまう。

```js
displayBtnDOMForAjax(); // Ajaxの取得処理

const btn = document.getElementById('btn');

```

なので、非同期処理が実行したあとに、処理を走らせたいというケースがある。

こういうときに使用できるのがasync awaitだったりする。


## Promiseについて

非同期処理の実行順を制御するときは、基本的にはPromiseというオブジェクトを利用する。

非同期処理は実行順序を保証しないので、それをPromiseでラップするイメージでいいのかな。

余談だけど、「じゃあ非同期やめればいいじゃん」って思ったので改めて確認しておく。
非同期をやめると指定の処理が終わるまで次の処理が実行されない。これではユーザビリティが下がる。
そのため、**非同期で実装したいが、一部を逐次的に実行したい**というときにPromiseを使う。

## PromiseはResolverを返却することで終了を認識する

Promiseを使って実装すると、Promiseオブジェクトが返却されるのでPromise内で実行された非同期処理の中での戻り値を設定しても取得できない。
そのため、Promiseの中では、Resolverを宣言する。

これは`function`でいうところの`return`のようなもので、`new Promise`の中で記載しておくと、その戻り値は`resolver("ここ")`になる。

## Promiseオブジェクトにはthen関数がある

Promiseオブジェクトには、then関数が定義されている。そのためPromise内のthen関数を用いて下記のようにかける

```js
new Promise((resolver) => {
  // 非同期処理
  resolve($resultData)
}). then(() => {
  // 非同期処理終了後にやりたいこと
})

```

[Promise.prototype.then() - JavaScript | MDN](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Promise/then)


こうやって実行順序を保証する。

ただ、冗長だしネストが深いということで、asyncなどを用いる

## async await

上記の処理はasyncとawaitを使うと次のようにかける

```js

function getData()
{
  return new Promise( resolver => {
    //非同期処理
    resolve('success')
  })
}

async function init(){
  await getData()
  // getDataの非同期処理が終わりを待って実行
}

//init を実行する
init();

```

awaitを使うときはasync関数の中で使用しなければならない。
できないのだが、仮に任意の場所で使用することができてしまうとすべての処理が逐次処理になってしまうだろう。
上記の場合init()という関数を非同期処理で呼び出すので、init()以下の後続の処理も実行される。
なのでawaitをしたいときはasyncで関数化してあげて、それも非同期処理としてあげないといけない。

- 実行順序を決めるための非同期処理をPromiseでラップし
- awaitで実行順を記載した処理をまとめて非同期処理の宣言であるasyncをつける
- それでasync関数は非同期で実行されるために、後続処理も結果を待たずに使用できる

という感じだろう

## asyncはPromiseオブジェクトを返却する関数となる

new PromiseによってPromiseオブジェクトを返却するのだが、カッコが多くて視認性が悪い。そのためasyncを使えば `new Promise`や`resolve`を見慣れた書き方に変えられる

```js

// function getData()
// {
//   return new Promise( resolver => {
//     //非同期処理
//     resolve('success')
//   })
// }

// 上記はasyncを使うとここまで簡潔に書ける。これは全く同じ意味
async function getData()
{
  return 'success'
  })
}

async function init(){
  await getData()
  // getDataの非同期処理が終わりを待って実行
}

//init を実行する
init();

```

まあこのせいで、asyncとawaitの関係がごちゃごちゃになる。。。
awaitを使う関数にasyncをつけるのか？でもawaitはasyncの中でしか使えんけどどういうこと？？とかそういう。。。

## 混乱しないようにまずはpromiseを使おう

結果だけ覚えてしまうと絶対にまた混乱してしまうのは目に見えている。
なれるまでは、Promiseで書いて、その後リファクタリングでPromiseオブジェクトをasyncに書き換えて上げるほうがイメージ付きやすい気がするね。
