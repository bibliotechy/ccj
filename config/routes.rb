Rails.application.routes.draw do

    # defailt locale when one is not specified: localhost:3001/books
    scope "(:locale)", locale: /en|jp/ do
        resources :works
        resources :artists
        resources :components
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



