Rails.application.routes.draw do
  defaults format: :json do
    resources :categories, format: :json
    resources :publications, format: :json do
      get 'most_viewed', on: :collection
      get 'last_post', on: :collection
    end
  end
end
