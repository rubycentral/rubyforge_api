ActionController::Routing::Routes.draw do |map|
  map.resources :mirrors

  parent_actions = [:create, :new, :index]

  map.resources :groups do |group|
    group.resource :news_bytes, :only => parent_actions
    group.resources :packages, :only => parent_actions
  end
  
  map.resources :packages, :except => parent_actions do |package|
    package.resources :releases, :only => parent_actions
  end
  
  map.resources :releases, :except => parent_actions do |release|
    release.resources :files, :member => 'downloads'
  end
  
  map.resources :news_bytes, :except => parent_actions
  
  map.resources :users, :member => [:groups]
  
  map.resources :processors
  
  map.status '/status', :controller => 'status', :action => 'status'
end
