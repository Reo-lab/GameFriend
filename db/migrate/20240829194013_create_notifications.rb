# frozen_string_literal: true

# CreateNotifications
class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
