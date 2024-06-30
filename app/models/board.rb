class Board < ApplicationRecord
  belongs_to :user
  has_many :boards_requests
  has_many :boards_chatrooms
  has_many :boards_gametitles
  has_many :boards_tags
end
