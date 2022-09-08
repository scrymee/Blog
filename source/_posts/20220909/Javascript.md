---
categories:
  - programming
tags:
  - [Javascript]
  - [Promise]
date: 2022-09-09 00:32:04
title: Promiseで対話的処理を実現する
---

<!-- toc -->

<!-- more -->

## 対話的処理を実現したい

下記のような処理で対話処理を実現しているケースが有った。

1. `なにか入力してください`の文言が出たあとに、

2. DOMで定義したbtn要素に準じたものをクリックしたら、

3. 「Messageですね。OKです！」と出力される

というフローだ。

基本的には、whileがtrue要素で無限ループされるのだが、async awaitによってawait要素で次の処理が停止される。await要素はresolveが返却されるまで待機される。
そして「Message」がresolveに登録されることで、ようやく次の処理が進行される。
そしてすぐに、ループ処理となり、「なにか入力してください」が再度出力される。

```js

let inputResolve = null;

window.onload = () => {
  btn.onclick = () => {
    inputResolve('Message');
  }
  talk()
}

const talk = async() => {
  while (true) {
    console.log(`なにか入力してください`)

    const input = await new Promise( resolve => {
      inputResolve = resolve;
    })

    console.log(`${input}} ですね。OKです！`)
  }
}

```

このあたりの動作がどうも納得できなかったので確認する

## Promiseのresolveについて理解する

処理の流れを細かく分類すると下記になる。

### 1. `inputResolve`にPromise内の引数である`resolve`が登録される。

resolveはfunctionだと思ってもらって差し支えない。　そう考えるとinputResolve = resolveということは実質的に下記と同じ。

```js

let inputResolve

inputResolve = () => {
  //処理
}

```

つまりこの関数を呼び出す場合は、`inputResolve()`で呼び出すことができるというわけ。


### 2. その後awaitなので後続の処理は実行されず、待機する

まあいうまでもなく。

### 3. `btn.onclick`が実行されたときに1の関数を呼び出してあげる

呼び出すことにより、Promise内でよく記載しているresolve()が実行されるのと同意義となる。もしinputResolveのカッコ内に文字列を入れた場合は、`resolve('MESSAGE')`などと同じだろう


```js

const input = await new Promise (resolve => {
  resolve('MESSAGE')
})

```

これを見ると、inputにはresolve内の文字であるMESSAGEが格納される。

そして、このresolve()はPromise内ではなく外部から実行しても成立するようだ

### 4. 外部からのresolve()の実行によってawaitの戻り値がセットされ処理が進む

あえて書くと下記のようだろう。ただ、resolveは`new Promise`に紐付いているようだ。内部に何かしら識別子でもあるのだろうか。


```js

resolve('MESSAGE') //　実際にはこのように書いてもPromise内のResolveを呼び出しているわけではないので動かないが、意味合いとしてはこういう感じで呼び出していると思ってもよい


const input = await new Promise (resolve => {
  resolve('MESSAGE') // これをPromise内部で行うのではなくグローバル変数を用いて外部で実行しても処理としては成立する
})


```

そのため、Promise外でも使用できるようにグローバル変数を定義してresolveを登録する。

それを変数で関数化したものを使って別のタイミングで呼び出してあげることで、await後続がすすむというわけだ

## まとめる

1. new Promise内のresolve（関数）を変数に入れる
2. その変数をグローバル化する
3. 変数を任意のタイミングで呼び出すとawaitにしているnew Promiseが進行するo

というわけだ

##　対話的処理で状態を管理し、ループにより同じだが文言が違うようなクイズ処理などで活躍しそうだ。

これを用いたら`for`などの中でも一時的に処理を停止して、ユーザーからの入力を待つことができる。クイズ問題の配列をループさせ、随時問題と会話を行うこともできるだろう。

なかなか良いアイデアだよなあ。

まあNode.jsとか使えばもっと簡単なんだろうけど、この発想は大好き。

## 例えばこんな漢字で実装

```js
let inputResolve

window.onload = async () => {
    talk()
    console.log('loading...');
    await new Promise(r => setTimeout(r, 2000))
    inputResolve('やっほー')

const talk = async() => {
        console.log('start');
        const answer = await new Promise(resolve => {
            inputResolve= resolve

        })
        console.log(answer)
        console.log('end');
        console.log('');

}

```

こうなるはずだ


```js

start
loading...
// 2秒待つ
やっほー
end

start
loading...
// 2秒待つ
やっほー
end

....

```