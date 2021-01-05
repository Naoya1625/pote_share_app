Rails.application.routes.draw do
  get 'reservations/index'
  root 'homes#index'

  #Room

  resources :rooms, except: [:edit, :show]
  get "booking/:id", to: "rooms#booking", as: "booking"
  post "reserve", to: "rooms#reserve"

  #Reservation
  resources :reservations, only: [:index, :new, :create]
  #get "reservations", to: "reservations#index"
  #get "reservations/new", to: "reservations#new"
  
  #User
  get 'users/show'
  get 'users/edit'

  #User(device)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


  devise_scope :user do
    get 'users/account' => 'users/registrations#account'
    get 'users/profile' => 'users/registrations#profile'
  end


  resources :users, only: [:show, :edit]


end
