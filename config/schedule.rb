# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, 'production'

# コマンドの出力をログファイルに保存
set :output, 'log/cron.log'

every 1.minute do
  command "cd /app && /usr/local/bundle/bin/bundle exec /usr/local/bundle/bin/rails runner -e production 'Board.where(openchanger: true).each(&:check_and_close!)' >> log/cron.log 2>&1"
end