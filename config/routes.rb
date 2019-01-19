Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/'  => "home#top"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/relationships/:id', to: 'relationships#create'
	delete '/relationships/:id', to: 'relationships#destroy'
  resources :users
  resources :meetings
end
