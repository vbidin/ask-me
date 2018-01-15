Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :rooms

  resources :questions

  resources :answers
  resources :given_answers

  resources :messages

  get 'roles' => 'roles#index'
  get 'types' => 'types#index'
  get 'permissions' => 'permissions#index'
  get 'given_answers' => 'given_answers#index'

  mount ActionCable.server => '/cable'
end
