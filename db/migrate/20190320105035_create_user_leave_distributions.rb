class CreateUserLeaveDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_leave_distributions do |t|
      t.integer :p_leave
      t.integer :s_leave
      t.integer :c_leave
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
