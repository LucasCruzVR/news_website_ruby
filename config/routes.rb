Rails.application.routes.draw do
  defaults format: :json do
    resources :categories, format: :json
  end
end
