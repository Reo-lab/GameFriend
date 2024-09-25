# frozen_string_literal: true

# BoardsTag
class BoardsTag < ApplicationRecord
  belongs_to :board
  belongs_to :tag
end
