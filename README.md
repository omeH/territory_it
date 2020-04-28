# README
This is test application was implemented according to requirements
on Ruby On Rails Engineer in Territory IT. Description of application are:

* Ruby version: 2.5.3

* Ruby On Rails version: 6.0.2.2

* System: Ubuntu 16.04.6 LTS

* Database: PostgreSQL 10.12

* Application Server: Puma (default)

# Additional data.
* To generate data you can use db:seed rake task. To configure task please see .env file.
    * RAILS_SEEDER_USERS: count of generated users (default: 100).
    * RAILS_SEEDER_POSTS: count of generated posts (default: 200_000).
    * RAILS_SEEDER_IPS: count of generated ips (default: 50).
    * RAILS_SEEDER_PROCESSES: count of processes task will be use (default: 5).
    * RAILS_SEEDER_URL: optional, if you pass url then task will use it to send request on endpoints.
* There are two rake tasks to send request on tor_ratings ans authors endpoints.
    * api:tests:top_ratings[url times processes] 
    * api:tests:authors[url times processes] 
