class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :group, optional: true

  def eligible_to_lead?
    group_leader_at.nil? || group_leader_at < 2.weeks.ago
  end
end
