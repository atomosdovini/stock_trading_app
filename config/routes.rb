Rails.application.routes.draw do

  devise_for :users
  root to: 'stocks#index'

  get 'stocks', to: 'stocks#index'
  get 'trades', to: 'operations#trades'
  # get 'my_stocks', to: 'operations#bought_stocks'


  post '/buy', to: 'operations#create'
  post '/sell', to: 'operations#create'
  get 'users/:id/balance', to: 'users#balance', as: 'user_balance'
  post '/operations/add_balance', to: 'operations#add_balance', as: 'add_balance'

  # resources :user_stocks do
  #   post 'buy', on: :member
  # end

  # post 'user_stocks/buy', to: 'user_stocks#buy', as: :buy_user_stock

  # resources :stocks do
  #   post 'user_stocks/buy', to: 'user_stocks#buy', as: :buy_user_stock
  # end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
