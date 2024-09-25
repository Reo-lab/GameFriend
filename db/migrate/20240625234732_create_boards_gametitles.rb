# frozen_string_literal: true

# CreateBoardsGametitles
class CreateBoardsGametitles < ActiveRecord::Migration[7.0]
  def change
    create_table :boards_gametitles do |t|
      t.references :board, null: false, foreign_key: true
      t.references :gametitle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
