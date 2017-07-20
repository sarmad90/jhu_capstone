# README

Ruby Version 2.3.1
Rails 5.0.0

Set:
ENV['POSTGRES_USER'], ENV['POSTGRES_PASSWORD'] and ENV['POSTGRES_HOST'] for config/database.yml

Mac:
brew services start mongodb
brew services stop mongodb

ENV['MONGO_HOST'], ENV['MLAB_URI'] for config/mongoid.yml

heroku config:set MLAB_URI=mongodb://<dbuser>:<dbpassword>@<dburl> --remote staging
