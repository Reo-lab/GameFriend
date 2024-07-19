class TopsController < ApplicationController
  before_action :set_gametitles, only: [:new, :edit, :create, :update]
  before_action :set_playstyles, only: [:index, :new, :edit]
  def index
    @boards = Board.all
    @gametitles = Gametitle.pluck(:gamename, :id)
    @search_boards = Board.all
    if params[:query].present? || params[:playstyle].present? || params[:playtime].present? || params[:gametitle].present?
      @search_boards = Board.search(params)
    end
  end

  private

  def set_playstyles
    @playstyles = ['カジュアル', 'ランク', 'スーパーカジュアル'] # 適切な選択肢を設定
  end

  def set_gametitles
    @gametitles = Gametitle.pluck(:gamename, :id)
  end
end
