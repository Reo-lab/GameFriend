class TopsController < ApplicationController
  def index
    @boards = Board.all
  end
end
