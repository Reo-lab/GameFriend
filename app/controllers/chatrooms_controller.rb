class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: [:show, :destroy, :add_users, :user_add, :remove_users]

  def index
    @chatrooms = Chatroom.joins(:boards_chatrooms_users).where(boards_chatrooms_users: { user_id: current_user.id })
  end

  def show
    @messages = @chatroom.messages
    @boards = @chatroom.boards.first
  end

  def new
    @chatroom = Chatroom.new
    @board_request = BoardsRequest.find(params[:board_request_id])
    @user = @board_request.user
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      user_ids = params[:chatroom][:user_ids].uniq
      create_boards_chatrooms_users(@chatroom, user_ids)
      redirect_to @chatroom, notice: 'チャットルームが作成されました。'
      board_id = params[:board_id]
      if board_id.present?
        boards = Board.find(board_id)
        @chatroom.boards << boards
      end
    else
      render :new
    end
  end

  def user_add
    @boards = @chatroom.boards
    @board_requests = @boards.map(&:boards_requests).flatten
  end

  def add_users
    if request.post?
      user_ids = params[:user_ids].reject(&:blank?)
      user_ids.each do |user_id|
        BoardsChatroomsUser.find_or_create_by(chatroom_id: @chatroom.id, user_id: user_id)
      end
      @boards = @chatroom.boards
      @board_requests = @boards.flat_map(&:boards_requests)
      redirect_to user_add_chatroom_path , notice: 'ユーザーが追加されました。'
    end
  end

  def remove_users
    if request.post?
      user_ids = params[:user_ids].reject(&:blank?)
      user_ids.each do |user_id|
        BoardsChatroomsUser.where(chatroom_id: @chatroom.id, user_id: user_id).destroy_all
      end
      @boards = @chatroom.boards
      @board_requests = @boards.flat_map(&:boards_requests)
      redirect_to user_add_chatroom_path, notice: 'ユーザーが削除されました。'
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path, notice: 'チャットルームが削除されました。'
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name,:board_id, user_ids: [])
  end

  def create_boards_chatrooms_users(chatroom, user_ids)
    user_ids.uniq.each do |user_id|
      BoardsChatroomsUser.find_or_create_by!(chatroom: chatroom, user_id: user_id)
    end
  end
end