FactoryBot.define do
  factory :group do
    trait :with_employees do
      after(:create) do |group, evaluator|
        employees = create_list(:employee, 4, group: group)

        leader = employees.first
        group.update(leader_id: leader.id)
      end
    end
  end
end
