# frozen_string_literal: true

# Gametitle
class Gametitle < ApplicationRecord
  has_one_attached :game_image
  has_many :boards_gametitles, dependent: :destroy
  has_many :boards, through: :boards_gametitles
end
