namespace :board do
  desc "Check and close open boards"
  task check_and_close: :environment do
    Board.where(openchanger: true).each(&:check_and_close!)
  end
end