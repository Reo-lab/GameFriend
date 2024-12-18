# ベースイメージの指定
FROM ruby:3.1.5

# 必要なパッケージをインストール
# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    yarn \
    default-mysql-client \
    cron \
    supervisor && \
    apt-get clean

# Tailwind CSS, PostCSS, Autoprefixer をインストール
RUN npm install -g tailwindcss postcss autoprefixer

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