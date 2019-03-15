class CreateLeaves < ActiveRecord::Migration[5.2]
  def change
    create_table :leaves do |t|
      t.date :sdate
      t.date :edate
      t.string :description
      t.string :type
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
