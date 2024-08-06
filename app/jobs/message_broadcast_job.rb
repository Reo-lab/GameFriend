class MessageBroadcastJob < ApplicationJob
  queue_as :default

  include Rails.application.routes.url_helpers

  def perform(message)
    ActionCable.server.broadcast "chat_channel_#{message.chatroom_id}", {
      message: {
        content: message.content,
        user_name: message.user.name,
        user_icon: rails_blob_path(message.user.icon_image, only_path: true),
        timestamp: I18n.l(message.created_at, format: :short)
      }
    }
  end
end