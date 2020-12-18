Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
       # get '/revenue', to: "revenue#index"
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'bizintel#merchant_revenue'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'bizintel#most_revenue'
        get '/most_items', to: 'bizintel#most_items'
      end
      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :merchants
      resources :items
    end
  end
end
