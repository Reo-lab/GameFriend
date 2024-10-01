# frozen_string_literal: true

# CreateSlideImages
class CreateSlideImages < ActiveRecord::Migration[7.0]
  def change
    create_table :slide_images do |t|
      t.references :users_slide, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
