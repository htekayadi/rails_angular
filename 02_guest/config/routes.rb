Rails.application.routes.draw do
  resources :guests, only: [:index, :create, :destroy], defaults: {format: :json}
  root to: "guests#index"
end
