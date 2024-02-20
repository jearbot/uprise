Rails.application.routes.draw do
  require "sidekiq/web"

  if defined?(Sidekiq)
    mount Sidekiq::Web => "/sidekiq"
  end

  root 'pages#index'
  devise_for :users,
    skip: [:registrations],
    controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords'
    }
  devise_scope :user do
    # sessions get
    get '/signin', to: 'users/sessions#new'

    # sessions post
    post '/signin', to: 'users/sessions#create'

    # sessions delete
    delete '/signin', to: 'users/sessions#destroy'
  end

  resources :members, only: [:index, :new, :create, :show]
  resources :archived_members, only: [:index]
  resources :message_templates, only: [:index, :new, :create]
  resources :sms_messages, only: [:index, :new, :create]
  resources :users, only: [:index, :new, :create, :show, :update, :destroy]

  post '/callbacks/twilio/receive', to: 'callbacks/twilio/message_receiver#create'
  post '/callbacks/twilio/status', to: 'callbacks/twilio/message_receiver#update'

  get "/google/calendars", to: "callbacks/google/calendars#index"
  get "/google/oauth2callback", to: "callbacks/google/calendars#oauth2callback"
  # get "/callbacks/google", to: "callbacks/google/calendars#callback"
  # get "/callbacks/google/calendars", to: "callbacks/google/calendars#calendars"
  # get "callbacks/google/calendars/events/:calendar_id", to: "callbacks/google/calendars#events", as: "events", calendar_id: "/[^\/]+/"
end
