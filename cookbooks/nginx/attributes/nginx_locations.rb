nginx_dir "/etc/nginx"
nginx_log_dir "/data/nginx/log"
nginx_apps_dir "/data/nginx/apps"
nginx_user attribute[:nginx_user] || attribute[:user]
nginx_binary "/usr/sbin/nginx"
