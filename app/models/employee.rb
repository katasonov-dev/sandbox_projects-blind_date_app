class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :group, optional: true
end
