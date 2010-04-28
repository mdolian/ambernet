REMOTE_CHEF_PATH = "/etc/chef" # Where to find upstream cookbooks

namespace :chef do
  desc "Test your cookbooks and config files for syntax errors"
  task :test do
    Dir[ File.join(File.dirname(__FILE__), "**", "*.rb") ].each do |recipe|
      sh %{ruby -c #{recipe}} do |ok, res|
        raise "Syntax error in #{recipe}" if not ok 
      end
    end
  
  end

  desc "Create dna from ruby file"
  task :create_dna  do
    dna_file = File.join(File.dirname(__FILE__), "config", "dna.rb")
    raise "There is no confit/dna.rb file! Take care of that!" unless File.exists? dna_file 
    sh "ruby #{dna_file}"
  end


  desc "Upload the latest copy of your cookbooks to remote server"
  task :upload => [:test, :create_dna]  do
    if !ENV["server"]
      puts "You need to specify a server rake upload server=whatever.com"
      exit 1
    end
  
    puts "* Upload your cookbooks *"  
    sh "rsync -rlP --delete --exclude '.*' #{File.dirname(__FILE__)}/ #{ENV['server']}:#{REMOTE_CHEF_PATH}"
    File.delete(File.dirname(__FILE__) + "/config/dna.json")
  end

  desc "Run chef solo on the server"
  task :cook => [:upload]  do
    if !ENV["server"]
      puts "You need to specify a server rake upload server=whatever.com"
      exit 1
    end
  
    puts "* Running chef solo on remote server *"  
    sh "ssh #{ENV['server']} \"cd #{REMOTE_CHEF_PATH}; chef-solo -l debug -c config/solo.rb -j config/dna.json \""
  end

  desc "Create a new cookbook (with cookbook=name)"
  task :new_cookbook do
    create_cookbook(File.join(File.dirname(__FILE__), "cookbooks"))
  end

  def create_cookbook(dir)
    raise "Must provide a COOKBOOK=" unless ENV["cookbook"]
    puts "** Creating cookbook #{ENV["cookbook"]}"
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "attributes")}" 
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "recipes")}" 
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "definitions")}" 
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "libraries")}" 
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "files", "default")}" 
    sh "mkdir -p #{File.join(dir, ENV["cookbook"], "templates", "default")}" 

    unless File.exists?(File.join(dir, ENV["cookbook"], "recipes", "default.rb"))
      open(File.join(dir, ENV["cookbook"], "recipes", "default.rb"), "w") do |file|
        file.puts <<-EOH
  #
  # Cookbook Name:: #{ENV["cookbook"]}
  # Recipe:: default
  #
  EOH
      end
    end
  end
end