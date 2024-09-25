# frozen_string_literal: true

# CreateGametitles
class CreateGametitles < ActiveRecord::Migration[7.0]
  def change
    create_table :gametitles do |t|
      t.string :gamename
      t.string :game_image

      t.timestamps
    end
  end
end
