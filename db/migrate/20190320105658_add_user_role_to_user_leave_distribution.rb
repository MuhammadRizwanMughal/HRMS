class AddUserRoleToUserLeaveDistribution < ActiveRecord::Migration[5.2]
  def change
    add_column :user_leave_distributions, :user_role, :string
  end
end
