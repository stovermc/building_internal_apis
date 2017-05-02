Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index, :show, :create]
      resources :orders, only: [:index, :show]
    end
  end
end
