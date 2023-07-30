class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :department_id, null: false
      t.integer :group_id

      t.datetime :group_leader_at
      t.timestamps
    end
  end
end
