Rails.application.routes.draw do
  root 'pages#home'
  resources :orders do
    post 'add_to_cart', on: :collection
    delete 'remove_from_cart', on: :collection
  end
  get '/signup', to: 'customers#new',as:'signup'

  resources :products
  resources :customers,except:[:new]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


end
