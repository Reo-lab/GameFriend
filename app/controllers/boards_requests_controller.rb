class BoardsRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]

  def index
    @boards = Board.all 
  end
  
  def show
    @board = Board.find(params[:id])
    @board_requests = @board.boards_requests
  end

  def create
    @board_request = @board.boards_requests.new(board_request_params)
    @board_request.user = current_user

    if @board_request.save
      redirect_to @board, notice: '応募が正常に送信されました。'
    else
      redirect_to @board, alert: '応募に失敗しました。'
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def board_request_params
    params.require(:boards_request).permit(:playtime, :freetext)
  end
end
