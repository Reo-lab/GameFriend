# ベースイメージの指定
FROM ruby:3.1.5

# 必要なパッケージをインストール
# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    default-mysql-client \
    cron && \
    apt-get clean

# 作業ディレクトリの作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# cronの設定ファイルを追加
COPY ./cronjob /etc/cron.d/mycron

# cronジョブの権限を設定
RUN chmod 0644 /etc/cron.d/mycron

# Bundlerのインストール
RUN gem install bundler:2.3.26
RUN bundle install

# アプリケーションのコードをコピー
COPY . /app

# アセットのプリコンパイル
RUN bundle exec rake assets:precompile

# サーバーの起動とcronサービスの開始
CMD service cron start && bundle exec puma -C config/puma.rb