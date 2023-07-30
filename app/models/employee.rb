class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :group, optional: true

  def eligible_to_lead?
    group_leader_at.present? && group_leader_at < 1.week.ago
  end
end
