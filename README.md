# Blind dates application

This application is dockerized so you may want to use docker to launch it:

* Steps:

Build docker images:

1. `docker-compose build` 

Run migrations and seed db:

2. `docker-compose run web rake db:migrate`

3. `docker-compose run web rake db:seed`

Start services:

4. `docker-compose up`

All done! You could browse the app by this address: http://0.0.0.0:3000



Scope:

1. Groups are getting created by GroupBuilderService. It takes all employees sorted by department and distributes employees across the groups
2. Index page created for Groups. There is a list of groups for current week
3. Each group has a leader which is assigned during group build by GroupBuilderService
4. Application is dockerized so setup should be quick and easy
5. It is possible to add and edit employees by Admin user
6. Group leader is able to choose a restaurant for his group

Admin user credentials:
email: `admin@email.com`
password: `password`

All users employees/admin has same password: `password`

Enjoy!
