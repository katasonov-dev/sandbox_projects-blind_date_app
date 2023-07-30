FactoryBot.define do
  factory :group do
    trait :with_employees do
      after(:create) do |group, evaluator|
        create_list(:employee, 4, group: group)
      end
    end
  end
end
