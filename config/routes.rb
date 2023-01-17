Rails.application.routes.draw do
  get 'users/new'
  defaults format: :json do
    resources :categories, format: :json
    resources :publications, format: :json do
      get 'most_viewed', on: :collection
      get 'last_post', on: :collection
    end
    resources :users
    post 'auth/sign-in', to: 'authentication#login'
    post 'auth/sign-up', to: 'authentication#sign_up'
  end
end
