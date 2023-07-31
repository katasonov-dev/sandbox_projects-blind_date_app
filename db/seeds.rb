ActiveRecord::Base.transaction do
  puts 'creating departments...'
  4.times.map { Department.create!(name: Faker::Commerce.department) }
  department = Department.all

  puts 'adding employees...'
  password =  'password'
  100.times.each { User.new(name: Faker::Name.name, department: department.sample, email: Faker::Internet.email, password: password, role: :employee).save! }

  puts 'generating admin user...'
  User.new(name: 'Admin User', email: 'admin@email.com', password: password, department: department.sample, role: :admin).save!
end
