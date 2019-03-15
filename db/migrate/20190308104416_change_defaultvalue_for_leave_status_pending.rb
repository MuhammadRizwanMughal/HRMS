class ChangeDefaultvalueForLeaveStatusPending < ActiveRecord::Migration[5.2]
  def change
  	change_column :leaves , :status , :string ,default: "pending"
  end
end
