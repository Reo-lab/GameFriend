# frozen_string_literal: true

class CreateHelperImages < ActiveRecord::Migration[7.0]
  def change
    create_table :helper_images do |t|
      t.string :title
      t.string :image_url
      t.integer :position

      t.timestamps
    end
  end
end
