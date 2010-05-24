ActionController::Routing::Routes.draw do |map|

  map.root :controller => "user_sessions", :action => "new"
  
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  
  map.login  "login",  :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  
  # Admin home page
  map.admin "/admin", :controller => "admin/dashboard"
  # Admin dashboard
  map.connect '/dashboard/:action', :controller => "admin/dashboard"
  # Admin routes
  map.namespace :admin do |admin|
    admin.resources :settings
    admin.resources :users
  end
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
