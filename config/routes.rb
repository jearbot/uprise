Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    # sessions get
    get '/signin', to: 'users/sessions#new'

    # sessions post
    post '/signin', to: 'users/sessions#create'

    # sessions delete
    delete '/signin', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
