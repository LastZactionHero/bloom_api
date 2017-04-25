Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/search/query', to: 'application#cors', via: [:options]
  match '/search/options', to: 'application#cors', via: [:options]
  match '/search/similiar', to: 'application#cors', via: [:options]
  match '/search/random', to: 'application#cors', via: [:options]
  match '/bed_templates', to: 'application#cors', via: [:options]
  match '/bed_templates/:id/placements', to: 'application#cors', via: [:options]
  match '/bed_templates/:id', to: 'application#cors', via: [:options]
  match '/zones/search', to: 'application#cors', via: [:options]
  match '/plants/:id/favorite', to: 'application#cors', via: [:options]
  match '/plants/:id/unfavorite', to: 'application#cors', via: [:options]

  post '/search/query', to: 'search#query'
  get '/search/options', to: 'search#options'
  get '/search/similar', to: 'search#similar'
  get '/search/random', to: 'search#random'
  post '/early_sign_up', to: 'early_sign_up#signup'
  get '/zones/search', to: 'zones#search'

  resources :bed_templates do
    collection do
      get :index
      get :suggestions
      post :create
    end
    member do
      patch :update
      delete :destroy
      get :placements
    end
  end

  resources :plants, only: [] do
    member do
      post :favorite
      post :unfavorite
    end
  end
end
