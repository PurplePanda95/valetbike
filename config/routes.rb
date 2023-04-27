Rails.application.routes.draw do
  # get 'rental/show'
  # get 'rental/new'
  # get 'rental/bike_return'
  # get 'rental/index'
  # get 'rental/confirm'
  post 'rentals/bike_return', to: 'rentals#bike_return', as: 'bike_return'
  resources :rentals
  get 'cards/index'
  get 'cards/show'
  get 'cards/new'
  get 'cards/edit'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  resources :billing_infos
  #get 'billing_infos/new'
  #get 'billing_infos/create'
  devise_for :logins, controllers: {
    sessions: 'logins/sessions',
    registrations: 'logins/registrations',
    passwords: 'logins/passwords',
    confirmations: 'logins/confirmations',

  }
  
  get 'membership/index'
  get 'membership/show'
  get 'membership/new'
  get 'membership/edit'
  get 'membership/delete'

  get 'pages/about'
  get 'pages/contact'
  get 'pages/faq'
  get 'pages/home'
  get 'pages/privacypol'
  get 'pages/terms'
  get 'pages/userag'
  get 'pages/rental'
  get 'pages/success'


  resources :stations do
    member do
      get :delete
    end
  end
  # get 'stations/index'
  # get 'stations/show'
  # get 'stations/new'
  # get 'stations/edit'
  # get 'stations/delete'

  resources :users do
  end
  get 'users/index'
  get 'users/show'
  

  root to: "pages#home"
end