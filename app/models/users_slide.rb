# frozen_string_literal: true

# UsersSlide
class UsersSlide < ApplicationRecord
  belongs_to :user
  has_many :slide_images, dependent: :destroy
end
