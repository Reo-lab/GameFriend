class User < ApplicationRecord
  has_one_attached :icon_image
  has_many :boards
  has_many :boards_requests
  has_many :boards_chatrooms_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
