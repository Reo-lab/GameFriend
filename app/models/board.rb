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
    return unless expired?

    update(openchanger: false)
  end

  def self.search(params)
    boards = Board.all
    boards = filter_by_playstyle(boards, params[:playstyle])
    boards = filter_by_playtime(boards, params[:playtime])
    boards = filter_by_gametitle(boards, params[:gametitle])
    filter_by_query(boards, params[:query])
  end

  class << self
    private

    def filter_by_playstyle(boards, playstyle)
      return boards unless playstyle.present?

      boards.where('playstyle LIKE ?', "%#{playstyle}%")
    end

    def filter_by_playtime(boards, playtime)
      return boards unless playtime.present?

      boards.where('playtime = ?', playtime)
    end

    def filter_by_gametitle(boards, gametitle)
      return boards unless gametitle.present?

      boards.where(boards_gametitle_id: gametitle)
    end

    def filter_by_query(boards, query)
      return boards unless query.present?

      boards.where('freetext LIKE ?', "%#{query}%")
    end
  end
end
