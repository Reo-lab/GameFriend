# frozen_string_literal: true

# MessageBroadcastJob
class MessageBroadcastJob < ApplicationJob
  queue_as :default

  include Rails.application.routes.url_helpers

  def perform(message)
    ActionCable.server.broadcast(
      "chat_channel_#{message.chatroom_id}",
      message_data(message)
    )
  end

  private

  def message_data(message)
    {
      message: {
        content: message.content,
        user_name: message.user.name,
        user_icon: user_icon_path(message.user),
        timestamp: formatted_timestamp(message)
      }
    }
  end

  def user_icon_path(user)
    if user.icon_image.attached?
      rails_blob_path(user.icon_image, only_path: true)
    else
      'default_icon.png'
    end
  end

  def formatted_timestamp(message)
    I18n.l(message.created_at, format: :short)
  end
end
