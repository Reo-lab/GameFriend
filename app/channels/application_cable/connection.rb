# frozen_string_literal: true

module ApplicationCable
  # ApplicationCable::Connection handles the connection to ActionCable.
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private

    def find_verified_user
      self.current_user = env['warden'].user
    end
  end
end
