# frozen_string_literal: true

# ChatChannelはサブスクライブとメッセージの送受信を提供しています
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Cleanup code
  end

  def speak(data)
    message = create_message(data['message'])
    broadcast_message(message)
  end

  private

  def create_message(content)
    Message.create!(
      content:,
      user: current_user,
      chatroom_id: params[:chatroom_id]
    )
  end

  def broadcast_message(message)
    ActionCable.server.broadcast(
      "chat_channel_#{params[:chatroom_id]}",
      message: {
        content: message.content,
        user_name: message.user.name,
        user_icon: message.user.icon_image.attached? ? url_for(message.user.icon_image) : 'default_icon.png',
        timestamp: l(message.created_at, format: :short)
      }
    )
  end
end
