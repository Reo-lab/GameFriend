class SessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "session_channel_#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end