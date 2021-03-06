Rails.application.routes.draw do
  resources :tests
  resources :test_sets
  resources :test_sets
  resources :tests
  root 'principal#index'
  get '/test_set/api/:video_url', to: 'api#find_test_set_from_video'
  get '/test_set/:test_set_id/tests', to: 'tests#show_tests_for_set'
  get '/test_set/:test_set_id/tests/new', to: 'tests#new'
  get '/test_set/:test_set_id/tests/:test_id/', to: 'tests#show'
  get '/test_set/:test_set_id/tests/:test_id/edit', to: 'tests#edit'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  get 'tests/new2/:params_test_set_id' => 'tests#new'



  # login facebook

  get "/auth/:provider/callback" => "sessions#create", as: :auth_callback
  get "/auth/failure" => "sessions#failure", as: :auth_failure
  get "/logout" => "sessions#destroy", as: :logout
  get "/login/:params" =>'sessions#index'

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
