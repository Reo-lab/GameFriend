class Chatroom < ApplicationRecord
  has_many :boards_chatrooms
  has_many :boards_chatrooms_users
end
