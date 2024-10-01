# frozen_string_literal: true

# SlideImage
class SlideImage < ApplicationRecord
  belongs_to :users_slide
  has_one_attached :image
end
