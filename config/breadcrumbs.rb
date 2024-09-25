# frozen_string_literal: true

crumb :root do
  link 'Top', root_path
end

crumb :menu do
  link 'menu', setups_path
  parent :root
end

crumb :request_index do
  link '応募中一覧'
  parent :root
end

crumb :boards_show do
  link '応募画面', boards_path
  parent :root
end

crumb :user_show do
  link 'プロフィール', user_path(current_user)
  parent :menu
end

crumb :boards_index do
  link '募集版一覧', boards_path
  parent :menu
end

crumb :boards_edit do |board|
  link '募集版編集', edit_board_path(board)
  parent :boards_index
end

crumb :boards_new do
  link '新規募集作成', new_board_path
  parent :menu
end

crumb :boards_request do
  link '応募状況一覧', boards_requests_path
  parent :menu
end

crumb :boards_request_show do
  link '応募状況詳細'
  parent :boards_request
end

crumb :chatrooms_index do
  link 'チャットルーム一覧', chatrooms_path
  parent :menu
end

crumb :chatrooms_show do |chatroom|
  link chatroom.name.to_s, chatroom_path(chatroom)
  parent :chatrooms_index
end

crumb :chatrooms_user_add do |chatroom|
  link 'ユーザー追加', add_users_chatroom_path(chatroom)
  parent :chatrooms_show, chatroom
end
# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
