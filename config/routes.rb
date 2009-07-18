ActionController::Routing::Routes.draw do |map|
  map.resources :groups do |groups_map|
    groups_map.resources :news_bytes
    groups_map.resources :packages do |packages_map|
      packages_map.resources :releases do |releases_map|
        releases_map.resources :files
      end
    end
  end
  map.resources :users do |users_map|
    users_map.resources :groups
  end
  map.resources :processors
end
