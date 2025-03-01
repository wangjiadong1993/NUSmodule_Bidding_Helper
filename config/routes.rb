Rails.application.routes.draw do
  get '/modules', to: "modules#index"
  get '/modules/mod_info/:id', to: "modules#mod_info"
  post 'modules/personal_info', to: "modules#personal_info"
  get 'modules/fast_search/:key_word', to: "modules#fast_search"
  get '/web/modules', to: 'web#modules'
  get '/modules/code_info/:id', to: 'modules#code_info'
  post "modules" => "modules#create", as: :nusmods
  get 'modules/new', to: "modules#new"
  get 'bid/show_code/:code', to: "bid#show_code"
  resources :locations,except: [:show]
  get "locations/post_new", to: "locations#post_new"
#  get '/locations/new', to: "locations#latest"
  # resources :modules
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
