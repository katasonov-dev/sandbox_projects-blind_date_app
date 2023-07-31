class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  belongs_to :department
  belongs_to :group, optional: true

  enum role: [:admin, :employee]

  def eligible_to_lead?
    group_leader_at.nil? || group_leader_at < 2.weeks.ago
  end
end
