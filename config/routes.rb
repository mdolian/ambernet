Ambernet::Application.routes.draw do |map|
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Venues before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]


  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  match '/admin' => 'recordings#admin'

  match 'recordings/admin' => "recordings#admin"
  match '/recordings/zip_link/:id/:filetype' => 'recordings#zip_link'
  match '/recordings/zip/:id/:filetype' => 'recordings#zip'
  match '/s/:id(.:format)' => 'recordings#stream'
  match '/stream/:id(.:format)' => 'recordings#stream'  
  resources :recordings

  #TO-DO add RESTful controller actions for venue
  #resources :venues
  match '/venues/city_list' => 'venues#city_list'
  match '/venues/list' => 'venues#list'
  match '/venues/admin' => 'venues#admin'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'   

  root :to => "index#index"
  
end
