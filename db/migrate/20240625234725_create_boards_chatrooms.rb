class CreateBoardsChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_chatrooms do |t|
      t.references :board, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
