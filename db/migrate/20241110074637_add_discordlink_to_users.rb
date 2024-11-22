# frozen_string_literal: true

# AddDiscordlinkToUsers
class AddDiscordlinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discord, :string
  end
end
