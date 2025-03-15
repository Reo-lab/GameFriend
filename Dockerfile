# ベースイメージの指定
FROM ruby:3.1.5

# 必要なパッケージをインストール
# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    curl \
    nodejs \
    default-mysql-client \
    cron \
    supervisor && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn && \
    apt-get clean

# 作業ディレクトリの作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundlerのインストール
RUN gem install bundler:2.3.26
RUN bundle install

RUN yarn add typescript

ENV PATH="/app/node_modules/.bin:$PATH"

# アプリケーションのコードをコピー
COPY . /app

RUN tsc --version

RUN yarn tsc

# start_cron.shに実行権限を付与
COPY start_cron.sh /app/start_cron.sh
RUN chmod +x /app/start_cron.sh

# cronの設定ファイルを生成
RUN bundle exec whenever --update-crontab

# アセットのプリコンパイル
RUN bundle exec rake assets:precompile
# supervisordの設定をコピー
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# サーバーの起動
CMD ["/usr/bin/supervisord", "-n"]