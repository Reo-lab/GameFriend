class NotificationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @notifications = current_user.notifications.order(created_at: :desc).limit(10)
    end
  
    def mark_all_as_read
      notifications = current_user.notifications.unread
      notifications.update_all(read: true)
      head :no_content # レスポンスとして空のヘッダーを返す
    end

    private
end