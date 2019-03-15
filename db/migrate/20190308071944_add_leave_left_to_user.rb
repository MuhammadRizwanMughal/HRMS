class AddLeaveLeftToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leave_left, :integer
  end
end
