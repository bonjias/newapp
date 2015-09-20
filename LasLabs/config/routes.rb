LasLabs::Application.routes.draw do
  get 'qbo/authenticate'

  get 'qbo/oauth_callback'
  
  # Qbo
  resources :qbo do
    get :authenticate
    get :oauth_callback
  end
  get 'qbo/new/invoice', to: 'qbo#new_invoice', as: 'qbo_new_invoice'
  
  resources :companies

  resources :authorized_users

  resources :invoices

  resources :time_entries
  get 'time_entries/invoice/new', to: 'time_entries#new_invoice', as: 'invoice_from_timesheet'

  get 'toggl', to: 'toggl#get', as: 'get_toggl'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"
end
