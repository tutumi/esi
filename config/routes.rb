Rails.application.routes.draw do
  resources :users
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  root :to => "static_pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
