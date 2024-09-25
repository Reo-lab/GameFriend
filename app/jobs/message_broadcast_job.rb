# frozen_string_literal: true

# MessageBroadcastJob
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  include Rails.application.routes.url_helpers

  def perform(message)
    ActionCable.server.broadcast "chat_channel_#{message.chatroom_id}", {
      message: {
        content: message.content,
        user_name: message.user.name,
        user_icon: if message.user.icon_image.attached?
                     rails_blob_path(message.user.icon_image,
                                     only_path: true)
                   else
                     'default_icon.png'
                   end,
        timestamp: I18n.l(message.created_at, format: :short)
      }
    }
  end
end
