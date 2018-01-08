Rails.application.routes.draw do
  resources :messages
  root 'home#index'

  devise_for :users

  resources :rooms

  resources :questions

  resources :answers

  get 'roles' => 'roles#index'
  get 'types' => 'types#index'
  
  get 'permissions' => 'permissions#index'
  get 'given_answers' => 'given_answers#index'
end
