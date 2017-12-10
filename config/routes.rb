Rails.application.routes.draw do
  
  resources :given_answers
  resources :answers
  resources :questions
  resources :types
  resources :permissions
  resources :roles
  resources :rooms
  devise_for :users
  root 'home#index'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
