class Group < ApplicationRecord
  has_many :employees

  scope :for_week, ->(week_number) { where(week_number: week_number) }

  def leader
    employees.find(leader_id)
  end
end
