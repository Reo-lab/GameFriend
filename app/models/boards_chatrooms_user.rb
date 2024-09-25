# frozen_string_literal: true

# BoardsChatroomsUser
class BoardsChatroomsUser < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
end
