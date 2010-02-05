namespace :db do
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
end