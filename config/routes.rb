ActionController::Routing::Routes.draw do |map|
  map.resources :groups do |groups_map|
    groups_map.resources :packages do |packages_map|
      packages_map.resources :releases
    end
  end
  map.resources :users
  map.resources :processors
end
