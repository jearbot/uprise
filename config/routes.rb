Rails.application.routes.draw do
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

  resources :members, only: [:index] do
    get '/members', to: 'members#index'
  end
end
