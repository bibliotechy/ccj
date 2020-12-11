Rails.application.routes.draw do

  mount Blacklight::Engine => '/'

  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog', :constraints => { :id => /[^\/]+/ } do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  namespace :admin do
    resources :artists
    resources :components
    resources :works
    resources :collections
    resources :uploads

    root to: "works#index"
  end

  resources :artists, only: [:show]
  resources :works, only: [:show], :constraints => { :user => /([^\/]+?)(?=\.json|\.html|$|\/)/ }
  resources :components, only: [:show]
  resources :collections, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
  get '/about' => 'pages#about'
end
