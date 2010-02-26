Ambernet::Application.routes.draw do |map|
  
  match 'tracks/edit/:id' => 'tracks#edit'
  
  match 'radio/stream' => 'radio#stream'

  # beta_controller
  match 'beta' => 'beta#index'
  match 'beta/index' => 'beta#index'
  match 'beta/contact' => 'beta#contact'
  match 'beta/bug' => 'beta#bug'

  # compilations_controller
  resources :compilations  
  
  # recordings_controller
  match 'recordings/zip_link/:id/:filetype' => 'recordings#zip_link'
  match 'recordings/zip/:id/:filetype' => 'recordings#zip'
  match 's/:id(.:format)' => 'recordings#stream'
  match 'stream/:id(.:format)' => 'recordings#stream'
  match 'recordings/search' => 'recordings#search'
  resources :recordings
  
  # scrape_controller
  match 'admin/scrape/perpetual_archives/:id' => 'scrape#perpetual_archives'  
  
  # shows_controller
  match 'shows/list' => 'shows#list'
  match 'shows/setlist' => 'shows#setlist'
  match 'shows/recordings' => 'shows#recordings'
  match 'shows/search' => 'shows#search'
  resources :shows
  
  # songs_controller
  match 'songs/list' => 'songs#list'
  resources :songs
    
  # tracks_controller
  # TO-DO

  devise_for :users
  
  # venues_controller
  match 'venues/city_list' => 'venues#city_list'
  match 'venues/list' => 'venues#list'
  match 'venues/admin' => 'venues#admin'
  resources :venues

  match 'admin' => 'admin#index'

  # root
  match 'index' => 'index#index'
  root :to => 'index#index'
  
end
