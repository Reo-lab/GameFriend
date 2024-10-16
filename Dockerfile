# ベースイメージの指定
FROM ruby:3.1.5

# 必要なパッケージをインストール
# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    default-mysql-client \
    cron \
    supervisor && \
    apt-get clean

# 作業ディレクトリの作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundlerのインストール
RUN gem install bundler:2.3.26
RUN bundle install

# アプリケーションのコードをコピー
COPY . /app

# cronの設定ファイルを生成
RUN bundle exec whenever --update-crontab

# cronの設定ファイルをコピー
COPY /etc/cron.d/mycron /etc/cron.d/mycron 

# アセットのプリコンパイル
RUN bundle exec rake assets:precompile
# supervisordの設定をコピー
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# サーバーの起動
CMD ["/usr/bin/supervisord", "-n"]