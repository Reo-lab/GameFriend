class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
    Rails.logger.info "User #{current_user.id} has subscribed to notifications channel."
  end
end
