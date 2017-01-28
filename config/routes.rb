Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/search/query', to: 'application#cors', via: [:options]
  match '/search/options', to: 'application#cors', via: [:options]

  post '/search/query', to: 'search#query'
  get '/search/options', to: 'search#options'
end
