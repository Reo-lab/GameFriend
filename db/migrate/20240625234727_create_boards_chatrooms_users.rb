# frozen_string_literal: true

# CreateBoardsChatroomsUsers
class CreateBoardsChatroomsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_chatrooms_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
