---
title: Hexoのテーマ「Icarus」カスタマイズまとめ
date:   2021/12/28 12:01:00
categories:
    - プログラミング
tags:
    - 環境構築 
---

IcarusはHexoのThemeの一つである。

公式ドキュメント

[Icarus](https://ppoffice.github.io/hexo-theme-icarus/)

作者のサイト

[如何给 Icarus 增加夜间模式 - iMaeGoo's Blog](https://www.imaegoo.com/2019/icarus-night-mode-2/)

## Icarusで記事のデザインを変更したい

「サムネイルの表示先を変更したい」「サムネイル未指定時にデフォルト画像を設定したい」「コメントや寄付ボタンなどの不要な機能を一旦削除したい」と思った。

そういうときには、`themes/icarus/layout/common/article.jsx`を修正する。(テーマのフォルダ名によっては、`themes/`に続くファイルパスが`icarus/`ではないかもしれない)

下記のように機能別でタグが書かれている。
コメントアウトするなり、位置を変更したり条件節を追加して上げると良い。

```jsx
    {/* Thumbnail */}
    { {has_thumbnail(page) ? <div class="card-image">
        {index ? <a href={url_for(page.link || page.path)} class="image is-7by3">
            <img class="thumbnail" src={get_thumbnail(page)} 
                        alt={page.title || get_thumbnail(page)} />
        </a> : <span class="image is-7by3">
            <img class="thumbnail" src={get_thumbnail(page)} 
                        alt={page.title || get_thumbnail(page)} />
        </span>}
    </div> : null} }
```

## Icarusでサイドバーのウィジェットを変更したい

`themes/icarus/_config.yml`にてウィジェット情報が記載されている。
例えば、初期表示されている「Google FeedBurner」と「Google Adsense」のウィジェットを非表示にする場合は、コメントアウト（または削除）してあげるだけで良い

### 変更前

```yml
    # Tags widget configurations
    -
        # Where should the widget be placed, left sidebar or right sidebar
        position: left
        type: tags
    # Google FeedBurner email subscription widget configurations
    -
        # Where should the widget be placed, left sidebar or right sidebar
        position: left
        type: subscribe_email
        # Hint text under the email input
        description: 
        # Feedburner ID
        feedburner_id: ''
    # Google AdSense unit configurations
    -
        # Where should the widget be placed, left sidebar or right sidebar
        position: left
        type: adsense
        # AdSense client ID
        client_id: ''
        # AdSense AD unit ID
        slot_id: ''
```

### 変更後

```yml
    # Tags widget configurations
    -
        # Where should the widget be placed, left sidebar or right sidebar
        position: left
        type: tags
    # # Google FeedBurner email subscription widget configurations
    # -
    #     # Where should the widget be placed, left sidebar or right sidebar
    #     position: left
    #     type: subscribe_email
    #     # Hint text under the email input
    #     description: 
    #     # Feedburner ID
    #     feedburner_id: ''
    # # Google AdSense unit configurations
    # -
    #     # Where should the widget be placed, left sidebar or right sidebar
    #     position: left
    #     type: adsense
    #     # AdSense client ID
    #     client_id: ''
    #     # AdSense AD unit ID
    #     slot_id: ''
```

## カテゴリを階層化せずに使用したい

Hexoではカテゴリやタグの書き方は下記のようになる。

```md

title: Hexoのテーマ「Icarus」カスタマイズまとめ
date:   2021/12/28 12:01:00
categories:
    - プログラミング
tags:
    - 環境構築 

```

複数のカテゴリを指定すると階層化されてしまう

`プログラミング>Hexo`と階層化されてしまう。

```md
title: Hexoのテーマ「Icarus」カスタマイズまとめ
date:   2021/12/28 12:01:00
categories:
    - プログラミング
    - Hexo
tags:
    - 環境構築 
```

対応策として、配列で記載する。これによ**り配列内に記載した組み合わせが階層化**される。
そのため別のリストで記載したカテゴリは階層化されない。

```md
title: Hexoのテーマ「Icarus」カスタマイズまとめ
date:   2021/12/28 12:01:00
categories:
    - [プログラミング]
    - [Hexo]
tags:
    - 環境構築 
```


## おわりに

icarusはダークモード（night mode）を実装できる点と見た目のスマートさから導入した。見た目も良いね。