class ChangeColumnNameTypeToLeaveTypeInLeave < ActiveRecord::Migration[5.2]
  def change
  	rename_column :leaves, :type, :leave_type
  end
end
