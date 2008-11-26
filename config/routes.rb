ActionController::Routing::Routes.draw do |map| 
  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'password_resets', :action => 'new'
  map.change_password '/change_password/:id', :controller => 'password_resets', :action => 'edit'
  #map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  #map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }
  
  # Restful Authentication Resources
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :password_resets
  #map.resources :passwords
  #map.resource :session
  map.resource :user_session #should change this controller to session
   
  # Home Page
  #map.root :controller => 'sessions', :action => 'new'
  map.root :controller => "user_sessions", :action => "new"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
