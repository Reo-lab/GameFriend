# frozen_string_literal: true

# Tag
class Tag < ApplicationRecord
  has_many :boards_tags
end
