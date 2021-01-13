Rails.application.routes.draw do

  root 'homes#index'

  #Room
  resources :rooms, except: [:edit, :show]
  get "booking/:id", to: "rooms#booking", as: "booking"
  get "rooms/posts", to: "rooms#my_room", as: "my_room"


  #Reservation
  resources :reservations, only: [:index, :new]
  post "reserve", to: "reservations#create"

  #get "reservations/new", to: "reservations#new"
  
  #User
  get 'users/show'
  #get 'users/edit', to: "users/passwords#edit"

  #User(device)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }



  devise_scope :user do
    get 'users/account' => 'users/registrations#account'
    patch 'users'    => 'users/registrations#update'
    get 'users/profile' => 'users/registrations#profile'    
  end
  patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'

  #resources :users, only: [:show, :edit]


end
