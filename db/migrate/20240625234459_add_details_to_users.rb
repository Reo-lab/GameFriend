# frozen_string_literal: true

# AddDetailsToUsers
class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :icon_image, :string
  end
end
