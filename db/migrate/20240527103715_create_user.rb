class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :age
      t.string :icon_image

      t.timestamps
    end
  end
end
