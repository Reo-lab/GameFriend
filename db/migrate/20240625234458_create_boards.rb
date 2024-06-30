class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :boards_gametitle_id
      t.string :playstyle
      t.integer :number_of_people
      t.boolean :openchanger
      t.integer :boards_tag_id
      t.datetime :playtime
      t.text :freetext

      t.timestamps
    end
  end
end
