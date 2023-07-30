class AddWeekNumberToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :week_number, :integer
  end
end
