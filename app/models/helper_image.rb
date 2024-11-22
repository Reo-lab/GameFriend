# frozen_string_literal: true

class HelperImage < ApplicationRecord
  has_one_attached :image_file
end
