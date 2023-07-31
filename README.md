# Blind dates application

This application is dockerized so you may want to use docker to launch it:

* Steps:
1. `docker-compose build` to build docker images
2. `docker-compose up` to start services

Run migrations and seed db:
`docker-compose run web rake db:migrate && rake db:seed`

All done, you may browse the app by this address: http://0.0.0.0:3000
