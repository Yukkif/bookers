Rails.application.routes.draw do

  root "homes#top"
  get "home/about" => "homes#about"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:show, :edit, :update,:index]
  resources :books, except: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
