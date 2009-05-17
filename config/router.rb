Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  # Adds the required routes for merb-auth using the password slice
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
  resources :users
  
  match('/s/:id.:format').to(:controller => 'recordings', :action => 'stream')
  match('/admin').to(:controller => 'recordings', :action => 'admin')
  match('/recordings/zip_link/:id/:filetype').to(:controller => 'recordings', :action => 'zip_link')  
  match("/recordings/zip/:id/:filetype").to(:controller => "recordings", :action => "zip").name(:zip)
  match('/').to(:controller => 'amberland', :action =>'index')
  default_routes
end