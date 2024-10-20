# frozen_string_literal: true

# Board
class Board < ApplicationRecord
  belongs_to :user
  has_many :boards_requests, dependent: :destroy
  has_many :boards_chatrooms, dependent: :destroy
  has_many :chatrooms, through: :boards_chatrooms
  has_many :boards_gametitles
  has_many :gametitles, through: :boards_gametitles
  has_many :boards_tags

  def gametitle
    boards_gametitles.first&.gametitle
  end

  def gametitle_id
    gametitle&.id
  end

  def set_end_time_24_hours_from_now
    self.end_time = Time.current + 24.hours
  end

  def expired?
    end_time && Time.current > end_time
  end

  def check_and_close!
    if expired?
      update(openchanger: false)
    end
  end

  def self.search(params)
    boards = Board.all
    boards = boards.where('playstyle LIKE ?', "%#{params[:playstyle]}%") if params[:playstyle].present?
    boards = boards.where('playtime = ?', params[:playtime]) if params[:playtime].present?
    boards = boards.where(boards_gametitle_id: params[:gametitle]) if params[:gametitle].present?
    boards = boards.where('freetext LIKE ?', "%#{params[:query]}%") if params[:query].present?
    boards
  end
end
