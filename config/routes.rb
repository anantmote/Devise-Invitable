Rails.application.routes.draw do

  namespace :admin do

    get '', to: 'dashboard#index', as: '/'
    resources :dashboard
    resources :categories
    resources :pages
    resources :userlogs do
      collection do
        get :mostactivepage
        get :mostactiveuser
        get :userpagecount
      end
    end
  end

  #devise_for :users, controllers: { invitations: 'devise/invitations' }
  #devise_for :users, :path_names => { :sign_up => "register" }  
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  # You can have the root of your site routed with "root"
  resources :dashboard
  resources :pages
  resources :userlogs
  root 'dashboard#home'
  get 'home' => 'dashboard#home'
  get 'about' => 'dashboard#about'
  get 'contact' => 'dashboard#contact'

  post '/ajax/sum3' => 'pages#ajax_sum3'
   
  #get 'learn' => 'pages#index'
  #get 'pages' => 'pages#index'
  
 

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
