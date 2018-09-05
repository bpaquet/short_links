Rails.application.routes.draw do
  resources :links
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#show'
  get 'info', to: 'info#show'
  
  get '/:name', to: 'links#redir'

  root to: "home#show"
end
