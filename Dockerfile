# ベースイメージの指定
FROM ruby:3.1

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs yarn default-mysql-client

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

# 開発サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]