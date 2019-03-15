class AddLeavesTakenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leaves_taken, :integer, default: 0;
  end
end
