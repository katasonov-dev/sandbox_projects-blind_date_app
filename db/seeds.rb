ActiveRecord::Base.transaction do
  puts 'creating departments...'
  6.times.map { Department.create!(name: Faker::Commerce.department) }
  department = Department.all

  puts 'adding employees...'
  password = 'password'
  100.times.each_with_index { |_, i| User.new(name: Faker::Name.name, department: department.sample, email: Faker::Internet.email + i.to_s, password: password, role: :employee).save! }

  puts 'generating admin user...'
  User.new(name: 'Admin User', email: 'admin@email.com', password: password, department: department.sample, role: :admin).save!

  puts 'gathering restaurants around...'
  50.times.each_with_index { |_, i| Restaurant.create!(name: Faker::Restaurant.name + i.to_s) }
end
