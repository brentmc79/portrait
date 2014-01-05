Portrait::Application.routes.draw do
  get "password_resets/new"
  resources :sites do
    post 'api', :on=>:collection
  end
  
  resources :users
  resources :password_resets
  
  post '/'=>'sites#api',  as: 'api'
  get  '/'=>'home#index', as: 'root'  
end
