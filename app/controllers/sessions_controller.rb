# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    chatroom_id = params[:session][:chatroomId]
    head :no_content
    ActionCable.server.broadcast "session_channel_#{chatroom_id}", session_params
  end

  private

  def session_params
    params.require(:session).permit(:type, :from, :to, :sdp, :candidate, :chatroomId)
  end
end