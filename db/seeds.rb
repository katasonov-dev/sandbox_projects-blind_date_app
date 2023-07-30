puts 'creating departments...'
4.times.each { |_| Department.create(name: Faker::Commerce.department) }
department_ids = Department.ids

puts 'adding employees...'
100.times.each { Employee.create(name: Faker::Name.name, department_id: department_ids.sample) }
