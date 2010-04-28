require 'rubygems'
require 'json'

dna = {
  :user => "mr_you",
  :mysql_root_pass => "REPLACE_ME!",
  
  :users =>  [
    {
      :username => "mr_you",
      :password => "REPLACE_ME!",
      :authorized_keys => "ssh-rsa ACfSXuMTJvY6Ys6zdxRljhzBbh/XHU8= bob@bob.com",
      :shell => "/bin/zsh",
      :gid => 1000,
      :uid => 1000,
      :sudo => true,
      :custom_files  => [{
        :name => ".zshrc",
        :content => File.read(File.dirname(__FILE__), "../config/custom/zshrc")
      }]
    },
    
    {
      :username => "mr_app",
      :gid => 1101,
      :uid => 1101,
      :authorized_keys => ["ssh-rsa ACfSXuMTJvY6Ys6zdxRljhzBbh/XHU8= bob@bob.com", "ssh-rsa ACfSXuMTJvY6Ys6zdxRljhzBbh/XHU8= cindy@bob.com"],
      :shell => "/bin/zsh",
    }
  ],
  
  :packages => [
    "imagemagick",
    "zsh",
    "zsh-doc",
    "vim"
  ],
  
  :applications => [
    {
      :name => "sample",
      :server_names => "_",
      :ports => [4000, 4001],
      :user => "mr_you",
      :group => "mr_you"
      #:custom_nginx_conf => File.read(File.dirname(__FILE__), "../config/custom/some-custom-nginx.conf")
    }
  ],
  
  :gems => [
    "rake", 
    {:name => "mysql", :version => "2.7"},
    "thin"
  ],
  
  :ebs_volumes => [
    {:device => "sdq1", :path => "/data"},
    {:device => "sdq2", :path => "/db"}
  ],
  
  :cronjobs => [
    {:name => "a_dumb_task",
     :minute => 30,
     :hour => nil,
     :day => nil,
     :month => nil,
     :weekday => nil,
     :user => "mr_app",
     :command => "date >> /data/look_cron_works.txt"
    }
  ],
  
  :recipes => [
    "packages",
    "users",
    "sudo",
    "openssh",
    "ec2-ebs",
    "mysql",
    "git",
    "logrotate",
    "nginx",
    "memcached",
    "cron",
    "gems",
    "rack_apps"
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)