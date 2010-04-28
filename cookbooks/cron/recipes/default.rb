#
# Cookbook Name:: cron
# Recipe:: default
#

for cronjob in node[:cronjobs]
  cron cronjob[:name] do
    minute  cronjob[:minute]
    hour    cronjob[:hour]
    day     cronjob[:day]
    month   cronjob[:month]
    weekday cronjob[:weekday]
    user    cronjob[:user]
    command cronjob[:command]
  end
end if node[:cronjobs]