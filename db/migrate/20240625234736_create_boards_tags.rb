# frozen_string_literal: true

# CreateBoardsTags
class CreateBoardsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_tags do |t|
      t.references :board, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
