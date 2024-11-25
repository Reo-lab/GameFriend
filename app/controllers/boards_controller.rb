# frozen_string_literal: true

# BoardsController
class BoardsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_board, only: %i[show edit update destroy toggle_openchanger]
  before_action :set_gametitles, only: %i[new edit create update]
  before_action :set_playstyles, only: %i[index new edit]

  def index
    @boards = Board.where(user: current_user).includes(:user)
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
    @board.set_end_time_24_hours_from_now

    if @board.save
      redirect_to boards_path, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: '募集版が削除されました。'
  end

  def toggle_openchanger
    if @board.toggle!(:openchanger)
      @board.update(end_time: Time.current + 24.hours) if @board.openchanger?
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
    @playstyles = %w[カジュアル ランク スーパーカジュアル] # 適切な選択肢を設定
  end

  def set_gametitles
    @gametitles = Gametitle.pluck(:gamename, :id)
  end

  def board_params
    params.require(:board).permit(:boards_gametitle_id, :playstyle, :number_of_people, :openchanger, :boards_tag_id,
                                  :playtime, :freetext)
  end
end
