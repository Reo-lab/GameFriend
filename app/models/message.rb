# frozen_string_literal: true

# Message
class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  after_create_commit { MessageBroadcastJob.perform_later self }
end
