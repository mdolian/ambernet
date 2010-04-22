Ambernet::Application.routes.draw do |map|

  # tracks_controller
  match 'tracks/edit/:id' => 'tracks#edit'
  match 'tracks/list/:recording_id/:track' => 'tracks#list'
  match 'tracks/save' => 'tracks#save'   
  
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
  match 'recordings/rate/:id/:rating' => 'recordings#rate'
  match 'recordings/browse' => 'recordings#index'
  resources :recordings
  
  # scrape_controller
  match 'scrape/perpetual_archives' => 'scrape#perpetual_archives'  
  
  # shows_controller
  match 'browse' => 'shows#browse'
  match 'shows/browse' => 'shows#browse'
  match 'shows/list' => 'shows#list'
  match 'shows/setlist/:id' => 'shows#setlist'
  match 'shows/recordings/:id' => 'shows#recordings'
  match 'shows/search' => 'shows#search'
  resources :shows
  
  # songs_controller
  match 'songs/list' => 'songs#list'
  resources :songs

  devise_for :users
  devise_for :admins
  
  # venues_controller
  match 'venues/city_list' => 'venues#city_list'
  match 'venues/list' => 'venues#list'
  resources :venues

  # search_controller
  match 'search' => 'search#advanced_search'
  match 'search/simple_search' => 'search#simple_search'
  match 'search/advanced_search' => 'search#advanced_search'  
  match 'search/simple_search_results' => 'search#simple_search_results'
  match 'search/advanced_search_results' => 'search#advanced_search_results'

  # admin_controller
  match 'admin' => 'admin#index'
  match 'admin/import' => 'admin#import'
  
  # root
  match 'index' => 'index#index'
  root :to => 'index#index'
  
end
