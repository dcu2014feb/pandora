Walko::Application.routes.draw do

  get "busqueda/new"
  post "busqueda/index"

  get "ldi/:id_ldi/comentario" => "comentario#new"
  post "ldi/:id_ldi/comentario" => "comentario#create"
  get "ldi/:id_ldi/comentario/edit/:id_com" => "comentario#edit"
  post "ldi/:id_ldi/comentario/edit/:id_com" => "comentario#update"
  delete "ldi/:id_ldi/comentario/delete/:id_com" => "comentario#destroy"

  get "ldi/new" => "ldi#new"
  post "ldi/new" => "ldi#create"
  get "ldi/edit/:id" => "ldi#edit"
  patch "ldi/edit/:id" => "ldi#update"
  delete "ldi/delete/:id" => "ldi#destroy"

  get "poblacion/:id" => "poblacion#show"
  devise_for :usuarios

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'busqueda#new'

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
