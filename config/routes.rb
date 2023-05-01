Rails.application.routes.draw do
  # get 'rental/show'
  # get 'rental/new'
  patch 'rentals/return'
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
  get 'add_membership', to: 'membership_assignment#new', as: 'add_membership'

  root to: "pages#home"

  resources :charges
  resources :membership
  resources :membership_assignment

  get 'thanks', to: 'charges#thanks', as: 'thanks'

  default_url_options :host => "127.0.0.1:3000"

  post 'checkouts/create' => 'checkouts#create', as: "checkouts_create"
  get 'checkouts/pay' => 'checkouts#pay', as: "checkouts_pay"
  post 'membership_assignment/create' => 'membership_assignment#create', as: "membership_assignment_create"
  
  get 'membership_assignments/confirm' => 'membership_assignment#confirm', as: "membership_assignment_confirm"
  get 'membership_assignment/show' => 'membership_assignment#show', as: "membership_assignment_show"
  # get '/checkout-session' do
  #   content_type 'application/json'
  #   session_id = params[:sessionId]
  
  #   session = Stripe::Checkout::Session.retrieve(session_id)
  #   session.to_json
  # end
  resources :webhooks, only: [:create]
end