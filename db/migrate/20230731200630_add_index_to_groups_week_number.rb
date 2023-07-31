class AddIndexToGroupsWeekNumber < ActiveRecord::Migration[7.0]
  def change
    add_index :groups, :week_number
  end
end
