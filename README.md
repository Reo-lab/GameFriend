# GameFriend
# ■ サービス概要
リアルタイムで一緒にゲームがしたい人達を表示する、ゲーマーマッチングアプリです。

一緒にゲームをする人が今いない、そんなときに全国から一緒に遊べる人を探せます。

ゲーマー達の繋がりをさらに広げて気が合う人達と出会えるそんなサービスです。

# ■ このサービスへの思い・作りたい理由

- 誰かと一緒に遊びたい、一人より複数人で遊んだ方が絶対楽しい、けどいまフレンドは用事があって遊べない。

- そんなときに、Twitterやディスコードで野良募集をしてみるけれどなかなか見つからない。

- 募集していたらもう寝る時間で、結局誰とも遊べない。

- そんなことが多かったので、よりスムーズに遊べる人を探して見つけられるこのサービスを思いつきました。


# ■ ユーザー層について
## PCゲーマー

PCゲームとWEBブラウザは非常に親和性が高いと思います。

大体のpcゲーマーはゲームをしながら動画を見たり、待機時間でネットサーフィンをするものです。

なので入り口として、ブラウザサービスの利用ハードルは低いと思います。

## 一人ゲーマー
やはりゲームは、複数人で一緒にプレイした方が面白く楽しいです。

また、ゲームによっては複数人で協力する前提のものが多くあります。

実際に、フレンドとチームを組んでプレイする人が経験上多いです。

一緒に誰かと遊びたい人たち、上手くなるために教えてほしい人たち、誰かにコツを伝授したい人たち、そんな人たちがターゲットです。


# ■サービスの利用イメージ

まずユーザーがサイトに訪れたら、リアルタイムで野良募集をかけている人たちがトップページに表示されます。

その募集条件を見て自分に合っていると思う募集に応募します。また、募集に合いそうなものがなければ自分で募集を作成します。

応募をした後に、募集をしている側が承諾すると、2人だけのチャットルームが作成されます。

そこで、チャットやボイスチャットを通じて、実際にプレイするか、ゲームでフレンドになるか、どこで通話するかなどを話し合っていただけます。


これによって、ユーザーはスムーズに一緒にゲームをする人を見つけられ、楽しいゲームライフを送ることができます。


# ■ ユーザーの獲得について
TwitterやSNSでの宣伝を通じて、利用者を獲得していきたい。

想定したユーザー層に対してそれぞれどのようにサービスを届けるのか現状考えていることがあれば教えてください。

# ■ サービスの差別化ポイント・推しポイント
## 似たようなサービス
- ディス速
    - 差別化ポイント
        - 自分が設定したタグの募集があると通知が届く
        - リアルタイムでゲームをしたい人たちと出会える
        - 自分が設定したタグの募集があると通知が届く
        - 募集掲示板のようなものよりもユーザーはスムーズなマッチングができる
        - 通話機能
        - WEB上で通話がすぐできることで、どんな人かどうかをより早く把握できる
        - なりすましや、迷惑ユーザー対策になる

# ■ 機能候補
## MVPリリースまでに作っていたいもの
    - ログイン機能
    - プロフィール機能ー画像
    - リアルタイム募集機能ー表示/非表示
    - 募集検索機能
    - 募集応募機能
    - 応募許可機能
    - 通知機能
    - タグ機能
    - チャットルーム機能（特定のユーザだけが入室できる場所）
    - チャット機能
    - 滑らかなUI/UX
## 本リリースまでに作っていたいもの
    - ボイスチャット機能
    - サーバー募集掲示板
    - ディスコのリンク設定
    - 評価システム(できたら)
# ■ 機能の実装方針予定
    - 言語：Railsのみ
    - UI、UX
        - CSSライブラリ
    - ボイスチャット機能
        - ActionCable+Websocket+WebRTCによるP2P通信
        - 課題：通信量でかかるサーバーコスト（要検討）
    - チャット機能
        - ActionCable+Websocket
    - ユーザー認証
    　  - Device
    - 検索機能
        -Hotwire
    - 画像アップロード、表示
        - ImageMagick
        - MiniMagick
