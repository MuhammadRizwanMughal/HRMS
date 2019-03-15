class AddLeaveStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leave_status, :string, default: 'none'
  end
end
