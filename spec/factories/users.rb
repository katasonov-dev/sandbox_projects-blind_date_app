FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    department
    email { Faker::Internet.email }
    password { 'password' }
  end
end
