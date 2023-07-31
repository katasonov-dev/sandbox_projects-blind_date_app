class Group < ApplicationRecord
  has_many :users
  belongs_to :restaurant, optional: true

  scope :for_week, ->(week_number) { where(week_number: week_number) }

  def leader
    users.find(leader_id)
  end
end
