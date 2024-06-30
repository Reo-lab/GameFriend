class CreateBoardsRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_requests do |t|
      t.references :board, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :playtime
      t.text :freetext

      t.timestamps
    end
  end
end
