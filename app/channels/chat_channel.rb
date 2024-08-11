class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Cleanup code
  end

  def speak(data)
    message = Message.create!(
      content: data['message'],
      user: current_user,
      chatroom_id: params[:chatroom_id]
    )
    ActionCable.server.broadcast(
      "chat_channel_#{params[:chatroom_id]}",
      message: {
        content: message.content,
        user_name: message.user.name,
        user_icon: message.user.icon_image.attached? ? url_for(message.user.icon_image) : 'default_icon.png', # アイコンがない場合はデフォルトの画像
        timestamp: l(message.created_at, format: :short)
      }
    )
  end
end