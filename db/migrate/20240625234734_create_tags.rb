# frozen_string_literal: true

# CreateTags
class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tagname

      t.timestamps
    end
  end
end
