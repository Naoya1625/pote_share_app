Rails.application.routes.draw do
  
  get 'users/show'
  get 'users/edit'
  root 'homes#index'

  resources :rooms, except: [:edit]
  get "booking", to: "rooms#booking"
  post "reserve", to: "rooms#reserve"

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
