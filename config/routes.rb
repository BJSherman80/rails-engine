Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
      end
      resources :merchants
      resources :items
    end
  end
end
