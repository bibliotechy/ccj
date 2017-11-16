Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


scope "/:locale" do
    resources :books
end



# defailt locale when one is not specified: localhost:3001/books
scope "(:locale)", locale: /en|nl/ do
    resources :books
end
