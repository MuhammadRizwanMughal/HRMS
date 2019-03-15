class AddTotalLeaveToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_leave, :integer, default: 20
  end
end
