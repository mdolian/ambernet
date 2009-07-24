namespace :db do

  def mysql_params
    hash = YAML.load(File.new(Rails.root + "config/database.yml")) 
    config = hash[Rails.env]
    options = {
      :host => "-h",
      :username => "-u",
      :password => "-p",
      :database => nil
    }.map { |key, option|
      value = config[key] || config[key.to_s]
      "#{option}#{value}" if value
    }.join(' ')
  end
  
  desc "Populate database"
  task :populate => :environment do
    fname = 'db/ambernet.sql.gz' if FileTest.exists?('db/ambernet.sql.gz')
    fname = 'db/ambernet.sql' if FileTest.exists?('db/ambernet.sql')    
    if fname =~ /\.gz$/
      sh "gunzip < #{fname} | mysql #{mysql_params}"
    else
      sh "mysql #{mysql_params} < #{fname}"
    end 
  
  end
    
  desc "Perform automigration"
  task :automigrate => :environment do
    FileList["app/models/**/*.rb"].each do |model|
      load model
    end
    ::DataMapper.auto_migrate!
  end

  desc "Perform non destructive automigration"
  task :autoupgrade => :environment do
    FileList["app/models/**/*.rb"].each do |model|
      load model
    end
    ::DataMapper.auto_upgrade!
  end

  namespace :migrate do
    task :load => :environment do
      gem 'dm-migrations'
      FileList["db/migrations/*.rb"].each do |migration|
        load migration
      end
    end

    desc "Migrate up using migrations"
    task :up, :version, :needs => :load do |t, args|
      version = args[:version]
      migrate_up!(version)
    end

    desc "Migrate down using migrations"
    task :down, :version, :needs => :load do |t, args|
      version = args[:version]
      migrate_down!(version)
    end
  end

  desc "Migrate the database to the latest version"
  task :migrate => 'db:migrate:up'
end
