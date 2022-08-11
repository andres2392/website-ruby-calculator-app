Rails.application.routes.draw do
  resources :user_pumps, only: [:create, :destroy]
  resources :pumps do 
    collection { post :import}
  end
  
  devise_for :users
  root 'welcome#index'
  get 'my_search', to: "users#my_search"
  get 'search_pump', to:"pumps#search"
  #pump finder GPM and FT
  get 'find_pump',to:"users#finder"
  get 'system_finder', to:"pumps#system_finder"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
