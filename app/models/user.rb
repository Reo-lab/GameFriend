class User < ApplicationRecord
  has_one_attached :icon_image
  has_many :boards
  has_many :boards_requests
  has_many :boards_chatrooms_users
  has_many :chatrooms, through: :boards_chatrooms_users
  has_many :messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable     
end
