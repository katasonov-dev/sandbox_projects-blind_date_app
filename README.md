# Blind dates application

This application is dockerized so you may want to use docker to launch it:

* Steps:
1. `docker-compose build` to build docker images

Run migrations and seed db:
2. `docker-compose run web rake db:migrate`
3. `docker-compose run web rake db:seed`

Start services:
4. `docker-compose up`

All done, you could browse the app by this address: http://0.0.0.0:3000
