## AmberNET 

  http://github.com/mdolian/ambernet

### Stack:

  Ruby 1.8.7 (2010-01-10 patchlevel 249)
  
  Rubygems 1.3.6
  
  Bundler 0.9.25
  
  Rails 3.0.0.beta2
  
  Mysql 5.X
  
  Resque 1.8.5
  
  Redis 1.2.01

### Quick Start

  Create a local database instance and create config/database.yml from sample file
  
  gem install bundler
  
  bundle install
  
  rake db:migrate
  
  gunzip db/ambernet.sql.gz
  
  mysql -uroot ambernet_development < db/ambernet.sql
  
  script/rails server
  
  curl http://localhost:3000 

### Sphinx

  TO-DO

### Redis

  TO-DO

### Resque 

  TO-DO
