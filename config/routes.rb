Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts

  constraints Rodauth::Rails.authenticated { |rodauth| rodauth.rails_account.system_admin? } do
    namespace :admin do
      get '/users',          to: 'rodauth#index'
      get '/users/new',      to: 'rodauth#new'
      post '/users/create',  to: 'rodauth#create'
      get '/users/edit',     to: 'rodauth#edit'
      patch '/users/update', to: 'rodauth#update'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
