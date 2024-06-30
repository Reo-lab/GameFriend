class CreatePermitRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :permit_requests do |t|
      t.references :boards_request, null: false, foreign_key: true
      t.boolean :change_mode

      t.timestamps
    end
  end
end
