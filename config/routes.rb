Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  get 'sessions/new'

  get 'users/new'
  get 'bus_stops/new'
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/home', to: 'static_pages#home'
  get '/currentbuses', to: 'static_pages#currentbuses'
  get  '/signup',  to: 'users#new'
  get  '/login',   to: 'sessions#new'
  post '/signup',  to: 'users#create'
  post '/login',   to: 'sessions#create'
  post "comments/:id" => "comments#edit"
  post "bus_stops/:id/show" => "bus_stops#show"
  post "bus_stops.:id" => "bus_stops#show"
  post "microposts/:id/show" => "microposts#show"
  post "controller" => "bus_stops#create"
  post "bus_stops/new" => "bus_stops#create"
  post "users/:id/edit"    => "users#edit"
  delete '/logout',  to: 'sessions#destroy'

  get '/Create', to: 'bus_stops#create'
  post "microposts/new" => "microposts#create"
  post '/StopCreate', to: 'bus_stops#create'


  resources :users
  resources :microposts,          only: [:create, :destroy]
  resources :comments
  resources :microposts do
      member do
        put "like", to:    "microposts#upvote"
        put "dislike", to: "microposts#downvote"
      end
      resources :comments
    end

  resources :bus_stops do
      resources :reviews, except: [:show, :index]
  end
end
