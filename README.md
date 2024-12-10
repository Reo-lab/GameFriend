# アプリ名【GameFriend】
![21](https://github.com/user-attachments/assets/95e7858f-4ed1-46c2-aaf5-c3ddde09691c)
<img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=flat">　<img src="https://img.shields.io/badge/-Rails-D30001.svg?logo=ruby-on-rails&style=flat">　<img src="https://img.shields.io/badge/-Docker-EEE.svg?logo=docker&style=flat">　<img src="https://img.shields.io/badge/-Amazon%20AWS-232F3E.svg?logo=amazon-aws&style=flat">

# 目次
- [サービス概要](#サービス概要)
- [サービスURL](#サービスurl)
- [サービス開発の背景](#サービス開発の背景)
- [サービスの利用イメージ](#サービスの利用イメージ)
- [技術構成について](#技術構成について)
  - [使用技術](#使用技術)
  - [ER図](#er図)
  - [画面遷移図](#画面遷移図)

##  ◇ サービス概要 ◇<a id="サービス概要"></a>
　一緒にゲームをしたい人達がリアルタイムで表示されるゲーマーのマッチングアプリです。

　ゲームをやりたいけど一緒に遊ぶ相手がいない、そんな時に全国から一緒に遊べる人を探せます。

　ゲーマー達の繋がりをさらに広げて、気が合う人達とすぐに出会えるそんなサービスです。


##  ◇ サービスURL ◇<a id="サービスurl"></a>
  https://gamefriend333.com/

<br>

##  ◇ サービス開発の背景 ◇<a id="サービス開発の背景"></a>

- 誰かと一緒に遊びたい。1人より複数人で遊んだ方が絶対楽しい。けど今は、フレンドが用事で遊べない。

- そんな時に、Twitterやディスコードで野良募集をしてみるけど、なかなか遊べる人が見つからない。

- 募集していたらもう寝る時間が来て、結局誰とも遊べない。

- そんなことが多かったので、よりスムーズに遊べる人を探して見つけられるこのサービスを思いつきました。



##  ◇ ユーザー層について ◇<a id="ユーザー層について"></a>
  ### ・PCゲーマー
&nbsp;&nbsp;&nbsp;&nbsp;PCゲームとWEBブラウザは非常に親和性が高いと思います。
   
&nbsp;&nbsp;&nbsp;&nbsp;大体のpcゲーマーはゲームをしながら動画を見たり、待機時間でネットサーフィンをするものです。
   
&nbsp;&nbsp;&nbsp;&nbsp;なので入り口として、ブラウザサービスの利用ハードルは低いと思います。

  ### ・1人ゲーマー
&nbsp;&nbsp;&nbsp;&nbsp;やはりゲームは、複数人で一緒にプレイした方が面白く楽しいです。
   
&nbsp;&nbsp;&nbsp;&nbsp;また、ゲームによっては複数人で協力する前提のものが多くあります。
   
&nbsp;&nbsp;&nbsp;&nbsp;実際に、フレンドとチームを組んでプレイする人が経験上多いです。
   
&nbsp;&nbsp;&nbsp;&nbsp; 一緒に誰かと遊びたい人、上手くなるために教えてほしい人、誰かにコツを伝授したい人、そんな人たちがターゲットです。

<br>

# ◇ サービスの利用イメージ ◇<a id="サービスの利用イメージ"></a>

| TOP画面 |
| :---: | 
| ![1](https://github.com/user-attachments/assets/796e54aa-310e-40ba-ba46-2ac75e9a9473) |
| まずユーザーがサイトに訪れたら、リアルタイムで募集をかけている人たちがトップページに表示されます。 |

| 募集版詳細画面 |
| :---: | 
| ![2](https://github.com/user-attachments/assets/4668247b-76f3-4466-864a-fcfc74d9fc9e) |
| その募集条件を見て自分に合っていると思う募集に応募します。 |

| 募集版作成 |
| :---: | 
| ![3](https://github.com/user-attachments/assets/b8235f6e-e97f-48e5-b7ad-a5e11e0c094a) |
| また、募集に合いそうなものがなければ自分で募集を作成します。 |

| チャットルーム画面　|
| :---: | 
| ![4](https://github.com/user-attachments/assets/9081b6d8-4f80-4fd9-a021-35e23d64dc36) |
| 応募をした後に、募集をしている側が承諾すると、チャットルームが作成されます。 |
| チャットやボイスチャットを通じて、実際にプレイするか、ゲームでフレンドになるか、どこで通話するかなどを話し合えます。 |

<br>

# 技術構成について

## 使用技術
| カテゴリ | 技術内容 |
| --- | --- | 
| サーバーサイド | Ruby on Rails 7.0.8・Ruby 3.1.5 |
| フロントエンド | Ruby on Rails・JavaScript |
| CSS | Sassc + Bootstrap |
| データベースサーバー | AWS RDS |
| アプリケーションサーバー | AWS EC2 puma|
| バージョン管理ツール | GitHub・Git Flow |

## ER図
https://drive.google.com/file/d/1PAuCEfaVNKZDHcNVUgEJmQouFgiSywZs/view?usp=sharing
<img width="1163" alt="2d043905e3474697b990967d52e4257c" src="https://github.com/user-attachments/assets/8b96dabf-2898-4d33-b913-a1174c5c879b">

## 画面遷移図
https://www.figma.com/design/ZamX8I47EiBqaJx7EYuRao/Reo's-team-library?node-id=2331-2&t=y65jO756HAS5tYlG-1

<br>

# 使用技術一覧

### 通話機能の実装方法
    - 自作かAPIを使用するかの可否
        - 技術力アピールのためにAPIの通話サービスを使用せず、最終的にすべて自作で作成

    - 自作で通話機能を作成した手順
        - 音声通話確立までの流れ
            - WebRTCを使用してブラウザ間のP2P接続を確立するためにSDPとICEの交換が必要
            - SDPとICE交換のためにシグナリングサーバーをセットアップ,この役割をRails Action Cableが担うようにする
                - actioncableをシグナリングサーバーとして使用する方法
                    - 以下のMITが公開しているシグナリングサーバーを参考にactioncableでのsignalingserver.jsを作成
                    - https://github.com/jeanpaulsio/action-cable-signaling-server
            - ユーザーが接続を開始すると、Rails Action Cable経由でSDPやICE情報を交換する。これにより、ブラウザ間でのP2P接続が確立される。
            - 接続が確立されると、ブラウザ間での音声ストリームの送受信が可能になり、リアルタイムの音声通話が実現される。

    - WebRTCとは
        -WebRTCとは(参考サイト)
            - WebRTCの概要：https://skyway.ntt.com/blog/entry/webrtc
            - WebRTCをほぼ学べるサイトhttps://zenn.dev/voluntas/scraps/82b9e111f43ab3

https://qiita.com/Reo-lab/items/90a037f5c18c027342d1


↑　通話機能の作成方法について、詳しくはこちらの記事に書いています

### 機能一覧
    - ログイン機能
    - プロフィール機能ー画像
    - リアルタイム募集機能ー表示/非表示
    - 募集検索機能
    - 募集応募機能
    - 応募許可機能
    - チャットルーム機能（特定のユーザだけが入室できる場所）
    - チャット機能
    - 滑らかなUI/UX
    - ボイスチャット機能
    - 通知機能
    - googleログイン
    - ディスコのリンク設定
    -- 今後実装したいもの　--
    - ユーザー評価システム
    - ゲームニュースやゲーマー情報などのニュースサイト
    - カスタムマッチングフィルター(超詳細な検索)


### 機能の実装技術一覧
    - 言語：Rails Javascript
    - 開発環境: Docker
    - サーバー：AWS(EC2+RDS)+nginx
    - UI、UX
        - CSS
    - ボイスチャット機能
        - ActionCable+Javascript+WebRTCによるP2P通信
        - 課題：通信量でかかるサーバーコスト（要検討）
    - チャット機能
        - ActionCable+Javascript
    - 通知機能
        - ActionCable+Javascript
    - ユーザー認証
    　  - Device
    - 画像アップロード、表示
        - ImageMagick
        - MiniMagick
    - テスト
        - rspec
        - rubocop
    - CI
        - GitHubActions
