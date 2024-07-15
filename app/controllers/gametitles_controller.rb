class GametitlesController < ApplicationController
  def index
    @gametitles = Gametitle.all
  end

  def show
  end

  def edit
  end

  def new
    @gametitle = Gametitle.new
  end

  def create
    @gametitle=Gametitle.new(gametitle_params)
    if @gametitle.save
      redirect_to @gametitle, notice: 'gametitle was successfully created.'
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def gametitle_params
    params.require(:gametitle).permit(:gamename, :game_image)
  end
end
