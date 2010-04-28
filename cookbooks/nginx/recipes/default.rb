package "nginx"

[node[:nginx_apps_dir], node[:nginx_dir]].each do |dir|
  directory dir do
    action :delete
    recursive true
  end
end

[node[:nginx_log_dir], node[:nginx_apps_dir], "/data/nginx/common"].each do |dir|
  directory dir do
    owner node[:nginx_user]
    group node[:nginx_user]
    mode 0755
    recursive true
  end
end

link node[:nginx_dir] do
  to "/data/nginx"
end

remote_file "/data/nginx/mime.types" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0755
  source "mime.types"
end

remote_file "/data/nginx/koi-utf" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0755
  source "koi-utf"
end

remote_file "/data/nginx/koi-win" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0755
  source "koi-win"
end

remote_file "/etc/logrotate.d/nginx" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0755
  source "nginx.logrotate"
  action :create
end

template "/data/nginx/nginx.conf" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0644
  source "nginx.conf.erb"
end

template "/data/nginx/common/proxy.conf" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0644
  source "common.proxy.conf.erb"
end

template "/data/nginx/common/app.conf" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0644
  source "common.app.conf.erb"
end

# Needed a files so the apps glob works...
file "#{node[:nginx_apps_dir]}/default.conf" do
  owner node[:nginx_user]
  group node[:nginx_user]
  mode 0644
end

service "nginx" do
  supports :status => false, :restart => true, :reload => true
  action [ :enable, :start ]
end
