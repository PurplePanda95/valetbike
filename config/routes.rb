Rails.application.routes.draw do
  # get 'rental/show'
  # get 'rental/new'
  # get 'rental/return'
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
  get 'users/show'
  

  root to: "pages#home"

  resources :charges
  resources :membership

  get 'thanks', to: 'charges#thanks', as: 'thanks'
end