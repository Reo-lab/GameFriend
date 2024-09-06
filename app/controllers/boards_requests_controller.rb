class BoardsRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]
  before_action :set_board_request, only: [:approve, :destroy]

  def index
    @boards = Board.all
  end

  def request_index
    @board_requests = BoardsRequest.all
  end

  def show
    @board = Board.find(params[:id])
    @board_requests = @board.boards_requests
  end

  def create
    @board_request = @board.boards_requests.new(board_request_params)
    @board_request.user = current_user

    if @board_request.save
      Notification.create(
      user: @board.user, 
      message: "募集版に応募が来ました。"
    )
      redirect_to @board, notice: '応募が正常に送信されました。'
    else
      redirect_to @board, alert: '応募に失敗しました。'
    end
  end

  def destroy
    @board_request.destroy
    redirect_to request_index_path, notice: '応募が取り消されました。'
  end

  def approve
    permit_request = PermitRequest.find_or_create_by(boards_request: @board_request, change_mode: true)

    if permit_request.update(change_mode: true)
      Notification.create(
      user: @board_request.user, 
      message: "応募が受け入れられました。新しいチャットルームが作成されました。"
    )
      redirect_to new_chatroom_path(board_request_id: @board_request.id)
    else
      redirect_to @board_request.board, alert: '応募の承認に失敗しました。'
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_board_request
    @board_request = BoardsRequest.find(params[:id])
  end

  def board_request_params
    params.require(:boards_request).permit(:playtime, :freetext)
  end
end