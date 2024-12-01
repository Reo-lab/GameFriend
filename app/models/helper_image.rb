# frozen_string_literal: true

# HelperImage
class HelperImage < ApplicationRecord
  has_one_attached :image_file
end
