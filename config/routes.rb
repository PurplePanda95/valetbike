Rails.application.routes.draw do
  # get 'rental/show'
  # get 'rental/new'
  patch 'rentals/return'
  get 'rentals/begin_return'
  # get 'rental/index'
  # get 'rental/confirm'
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
  get 'pages/paymentdemo'

  get 'membership_assignment/index'
  get 'membership_assignment/new'

  resources :stations do
    member do
      get :delete
    end
  end

  resources :users do
  end
  get 'users/index'
  get 'account', to: 'users#show', as: 'account'
  get 'rentals/return_at_dock', to: 'rentals#return_with_docks', as: 'rentals_return_at_dock'

  root to: "pages#home"

  resources :charges
  resources :membership

  get 'thanks', to: 'charges#thanks', as: 'thanks'

  default_url_options :host => "127.0.0.1:3000"
end