#
# Cookbook Name:: rack_apps
# Recipe:: default
#

include_recipe "nginx"
include_recipe "memcached"

node[:applications].each do |app|
  app[:user] ||= node[:user]
  app[:group] ||= app[:user]
  app_dir = "/data/apps/#{app[:name]}"
  
  directory app_dir do
    owner app[:user]
    group app[:group]
    mode 0755
    action :create
    recursive true
  end

  directory "#{app_dir}/shared" do
    owner app[:user]
    group app[:group]
    mode 0755
    action :create
    recursive true
  end

  directory "#{app_dir}/shared/config/" do
    owner app[:user]
    group app[:group]
    mode 0755
    action :create
  end
  
  # Nginx Setup
  # -----------
  template "#{node[:nginx_dir]}/apps/#{app[:name]}.conf" do
    owner app[:user]
    group app[:group]
    mode 0644
    source "app.conf.erb"
    variables(
      :app_name => app[:name],
      :app_dir => app_dir,
      :ports => [*app[:ports]],
      :http_bind_port => app[:bind_port] || 80,
      :server_names => app[:server_names],
      :custom_conf => app[:custom_nginx_conf]
    )
  end
  
  # Memcached setup
  # ---------------
  template "#{app_dir}/shared/config/memcached.yml" do
    owner app[:user]
    group app[:group]
    mode 0644
    source "memcached.yml.erb"    
    action :create
    
    variables(:app => app) 
  end
  
  # Mysql setup
  # -----------
  db_user_attrs = {:user => app[:user], :password => app[:password], :database => "#{app[:name]}_production"}
  
  template "#{app_dir}/shared/config/database.yml" do
    owner app[:user]
    group app[:group]
    mode 0655
    source "database.yml.erb"
    variables(db_user_attrs)
    action :create_if_missing
  end
  
  # Create empty db
  template "/tmp/empty-#{app[:name]}-db.sql" do
    owner 'root'
    group 'root'
    mode 0644
    source "empty-db.sql.erb"
    variables(db_user_attrs)
  end
  
  execute "create-empty-db-for-#{app[:name]}" do
    command "mysql -u root -p'#{node[:mysql_root_pass]}' < /tmp/empty-#{app[:name]}-db.sql"
  end
  
  # Setup a thin config file
  execute "create-thin-config-for-#{app[:name]}" do
    command "thin config --config #{app_dir}/shared/config/thin.yml \
                         --chdir /data/apps/#{app[:name]}/current \
                         --environment production \
                         --log #{app_dir}/shared/log/thin.log \
                         --pid #{app_dir}/shared/pids/thin.pid \
                         --user #{app[:user]} \
                         --group #{app[:group]} \
                         --port #{[*app[:ports]].first} \
                         --servers #{[*app[:ports]].size}".squeeze(" ")
  end
  
  execute "startup-#{app[:name]}" do
    command "thin start --config #{app_dir}/shared/config/thin.yml"
    only_if "[[ -f #{app_dir}/shared/config/thin.yml ]]"
  end
  
end if node[:applications]

service "nginx" do
  action [ :restart ]
end