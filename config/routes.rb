Rails.application.routes.draw do
  devise_for :users
  root'students#index'
  resources :students
  resources :homes 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
