ActionController::Routing::Routes.draw do |map|
  map.resources :groups do |groups_map|
    groups_map.resources :packages
  end
  map.resources :users
end
