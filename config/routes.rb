Rails.application.routes.draw do
  namespace :admin do
    resources :artists
    resources :components
    resources :works

    root to: "artists#index"
  end

  resources :artists
  resources :works
  resources :components
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
