class AddEndTimeToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :end_time, :datetime
  end
end
