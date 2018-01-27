Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :rooms

  resources :questions

  resources :answers

  resources :given_answers

  resources :messages

  resources :users

  get 'roles' => 'roles#index'
  get 'types' => 'types#index'
  get 'permissions' => 'permissions#index'

  mount ActionCable.server => '/cable'
end
