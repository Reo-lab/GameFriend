# frozen_string_literal: true

# BoardsGametitle
class BoardsGametitle < ApplicationRecord
  belongs_to :board
  belongs_to :gametitle
end
