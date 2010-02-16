Ambernet::Application.routes.draw do |map|
  resources :test2s

  resources :tests
  # admin root
  match 'admin' => 'recordings#admin'

  # beta_controller
  match 'beta/index' => 'beta#index'
  match 'beta/contact' => 'beta#contact'
  match 'beta/bug' => 'beta#bug'

  # compilations_controller
  resources :compilations  
  
  # recordings_controller
  match 'recordings/admin' => 'recordings#admin'
  match 'recordings/zip_link/:id/:filetype' => 'recordings#zip_link'
  match 'recordings/zip/:id/:filetype' => 'recordings#zip'
  match 's/:id(.:format)' => 'recordings#stream'
  match 'stream/:id(.:format)' => 'recordings#stream'   
  resources :recordings
  
  # scrape_controller
  match 'admin/scrape/perpetual_archives/:id' => 'scrape#perpetual_archives'  
  
  # shows_controller
  match 'shows/list' => 'shows#list'
  match 'shows/setlist' => 'shows#setlist'
  match 'shows/recordings' => 'shows#recordings'
  match 'shows/search' => 'shows#search'
  match 'shows/destroy/:id' => 'shows#destroy'  
  resources :shows

  # tracks_controller
  # TO-DO
  
  # venues_controller
  match 'venues/city_list' => 'venues#city_list'
  match 'venues/list' => 'venues#list'
  match 'venues/admin' => 'venues#admin'
  match 'venues/destroy/:id' => 'venues#destroy'
  resources :venues

  # root
  root :to => "index#index"
  
end
