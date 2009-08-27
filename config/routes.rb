ActionController::Routing::Routes.draw do |map|
  map.resources :groups, :has_many => [:news_bytes] do |groups_map|
    groups_map.resources :packages do |packages_map|
      packages_map.resources :releases, :has_many => [:files]
    end
  end
  map.resources :users, :has_many => [:groups]
  map.resources :processors
end
