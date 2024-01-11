Rails.application.routes.draw do
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#index'
  devise_for :users, controllers: {
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

  resources :members, only: [:index, :new, :create] do
    get '/members', to: 'members#index'
    get '/members/new', to: 'members#new'
    post '/members/new', to: 'members#create'
  end

  resources :message_templates, only: [:index, :new, :create] do
    get '/message_templates', to: 'message_templates#index'
    get '/message_templates/new', to: 'message_templates#new'
    get '/message_templates/create', to: 'message_templates#create'
  end

  resources :sms_messages, only: [:index, :new, :create] do
    get '/sms_messages', to: 'sms_messages#index'
  end

  resources :users, only: [:index, :new, :create] do
    get '/users', to: 'users#index'
    get '/users/new', to: 'users#new'
    post '/users/new', to: 'users#create'
  end

  get '/callbacks/twilio/receive', to: 'callbacks/twilio/message_receiver#create'


  get "/google/calendars", to: "callbacks/google/calendars#index"
  get "/google/oauth2callback", to: "callbacks/google/calendars#oauth2callback"



  # get "/callbacks/google", to: "callbacks/google/calendars#callback"
  # get "/callbacks/google/calendars", to: "callbacks/google/calendars#calendars"
  # get "callbacks/google/calendars/events/:calendar_id", to: "callbacks/google/calendars#events", as: "events", calendar_id: "/[^\/]+/"

end
