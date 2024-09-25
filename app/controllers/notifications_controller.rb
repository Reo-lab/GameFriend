# frozen_string_literal: true

# NotificationsController
class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def unread_count
    if user_signed_in?
      unread_count = current_user.notifications.unread.count
      Rails.logger.info("Unread notifications count: #{unread_count}")
      render json: { unread_count: }
    else
      Rails.logger.info('User not signed in')
      render json: { unread_count: 0 }
    end
  end

  def index
    notifications = if user_signed_in?
                      current_user.notifications.order(created_at: :desc).limit(10)
                    else
                      []
                    end
    render json: { notifications: }
  end

  def mark_all_as_read
    notifications = current_user.notifications.unread
    notifications.update_all(read: true)
    head :no_content # レスポンスとして空のヘッダーを返す
  end
end
