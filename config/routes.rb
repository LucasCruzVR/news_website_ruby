Rails.application.routes.draw do
  defaults format: :json do
    resources :categories, format: :json
    resources :publications, format: :json do
      get :
    end
  end
end
