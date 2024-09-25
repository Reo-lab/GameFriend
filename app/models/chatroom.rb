# frozen_string_literal: true

# Chatroom
class Chatroom < ApplicationRecord
  has_many :boards_chatrooms, dependent: :destroy
  has_many :boards, through: :boards_chatrooms
  has_many :boards_chatrooms_users, dependent: :destroy
  has_many :users, through: :boards_chatrooms_users
  has_many :messages, dependent: :destroy
end
