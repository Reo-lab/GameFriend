# frozen_string_literal: true

# CreateUsersSlides
class CreateUsersSlides < ActiveRecord::Migration[7.0]
  def change
    create_table :users_slides do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
