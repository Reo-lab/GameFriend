# frozen_string_literal: true

# ChatroomsController
class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: %i[show destroy add_users user_add remove_users]

  def index
    @chatrooms = Chatroom
                 .includes(:boards)
                 .includes(users: { icon_image_attachment: :blob })
                 .joins(:boards_chatrooms_users)
                 .where(boards_chatrooms_users: { user_id: current_user.id })
  end

  def show
    @messages = @chatroom.messages.includes(:user)
    @boards = @chatroom.boards.first
    @users = @chatroom.users.includes(icon_image_attachment: :blob)
  end

  def new
    @chatroom = Chatroom.new
    @board_request = BoardsRequest.find(params[:board_request_id])
    @user = @board_request.user
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)

    if @chatroom.save
      handle_chatroom_users
      handle_associated_board
      redirect_to @chatroom, notice: 'チャットルームが作成されました。'
    else
      render :new
    end
  end

  def user_add
    @boards = @chatroom.boards
    @board_requests = @boards.map(&:boards_requests).flatten
    @users = @chatroom.users.includes(icon_image_attachment: :blob)
  end

  def add_users
    return unless request.post?

    user_ids = params[:user_ids].reject(&:blank?)
    user_ids.each do |user_id|
      BoardsChatroomsUser.find_or_create_by(chatroom_id: @chatroom.id, user_id:)
    end
    @boards = @chatroom.boards
    @board_requests = @boards.flat_map(&:boards_requests)
    redirect_to user_add_chatroom_path, notice: 'ユーザーが追加されました。'
  end

  def remove_users
    return unless request.post?

    user_ids = params[:user_ids].reject(&:blank?)
    user_ids.each do |user_id|
      BoardsChatroomsUser.where(chatroom_id: @chatroom.id, user_id:).destroy_all
    end
    @boards = @chatroom.boards
    @board_requests = @boards.flat_map(&:boards_requests)
    redirect_to user_add_chatroom_path, notice: 'ユーザーが削除されました。'
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path, notice: 'チャットルームが削除されました。'
  end

  private

  def handle_chatroom_users
    user_ids = params[:chatroom][:user_ids].uniq
    create_boards_chatrooms_users(@chatroom, user_ids)
  end

  def handle_associated_board
    board_id = params[:board_id]
    return unless board_id.present?

    board = Board.find(board_id)
    @chatroom.boards << board
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name, :board_id, user_ids: [])
  end

  def create_boards_chatrooms_users(chatroom, user_ids)
    user_ids.uniq.each do |user_id|
      BoardsChatroomsUser.find_or_create_by!(chatroom:, user_id:)
    end
  end
end
