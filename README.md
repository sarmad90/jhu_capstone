# README

Ruby Version 2.3.1
Rails 5.0.0

Set:
ENV['POSTGRES_USER'], ENV['POSTGRES_PASSWORD'] and ENV['POSTGRES_HOST'] for config/database.yml
ENV['MONGO_HOST'], ENV['MLAB_URI'] for config/mongoid.yml


heroku config:set MLAB_URI=mongodb://<dbuser>:<dbpassword>@<dburl> --remote staging

Jim is using Angular 1.5.9 but we didn't provide a specific version to out Gemfile, that's why we're using Angular 1.6. 
