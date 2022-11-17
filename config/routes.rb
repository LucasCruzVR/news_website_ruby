Rails.application.routes.draw do
  defaults format: :json do
    resources :categories, format: :json
    resources :publications, format: :json
  end
end
