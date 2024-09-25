# frozen_string_literal: true

# CreateChatrooms
class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.integer :boards_chatrooms_user_id

      t.timestamps
    end
  end
end
