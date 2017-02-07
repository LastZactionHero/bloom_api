Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/search/query', to: 'application#cors', via: [:options]
  match '/search/options', to: 'application#cors', via: [:options]
  match '/bed_templates', to: 'application#cors', via: [:options]
  match '/bed_templates/:id/placements', to: 'application#cors', via: [:options]
  match '/bed_templates/:id', to: 'application#cors', via: [:options]

  post '/search/query', to: 'search#query'
  get '/search/options', to: 'search#options'
  post '/early_sign_up', to: 'early_sign_up#signup'

  resources :bed_templates do
    collection do
      get :index
      post :create
    end
    member do
      patch :update
      delete :destroy
      get :placements
    end
  end
end
