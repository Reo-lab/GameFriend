class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy, :toggle_openchanger]
  before_action :set_gametitles, only: [:new, :edit, :create, :update]
  before_action :set_playstyles, only: [:index, :new, :edit]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @board_request = BoardsRequest.new
  end

  def new
    @board = Board.new
    @gametitles = Gametitle.all.pluck(:gamename, :id)
  end

  def edit
    @gametitles = Gametitle.all.pluck(:gamename, :id)
  end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: 'Board was successfully updated.'
    else
      @gametitles = Gametitle.all.pluck(:gamename, :id)
      render :edit
    end
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user

    if @board.save
      redirect_to @board, notice: 'Board was successfully created.'
    else
      render :new
    end
  end


  def destroy
  end

  def toggle_openchanger
    if @board.toggle!(:openchanger)
      redirect_to boards_path, notice: 'Board was successfully changemode.'
    else
      render :board
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def set_playstyles
    @playstyles = ['カジュアル', 'ランク', 'スーパーカジュアル'] # 適切な選択肢を設定
  end

  def set_gametitles
    @gametitles = Gametitle.pluck(:gamename, :id)
  end

  def board_params
    params.require(:board).permit(:boards_gametitle_id, :playstyle, :number_of_people, :openchanger, :boards_tag_id, :playtime, :freetext)
  end
end
