class Restaurant < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :groups, dependent: :nullify
end
