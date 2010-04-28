#
# Cookbook Name:: packages
# Recipe:: default
#

for pacakge_name in node[:packages]
  package pacakge_name
end