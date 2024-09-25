# frozen_string_literal: true

# BoardsChatroom
class BoardsChatroom < ApplicationRecord
  belongs_to :board
  belongs_to :chatroom
end
