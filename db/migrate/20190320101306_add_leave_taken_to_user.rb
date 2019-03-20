class AddLeaveTakenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leave_taken, :integer
  end
end
