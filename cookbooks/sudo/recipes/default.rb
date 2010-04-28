#
# Cookbook Name:: sudo
# Recipe:: default
#

template "/etc/sudoers" do
  owner "root"
  group "root"
  mode 0440
  source "sudoers.erb"
end
