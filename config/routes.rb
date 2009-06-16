ActionController::Routing::Routes.draw do |map|
  # map.root :controller => "welcome"
  map.resources :groups do |groups_map|
    groups_map.resources :packages
  end
end
