Rails.application.routes.draw do


  devise_for :admins
  # To tell Devise to use our custom controller, allowing the company key to be saved
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :surveys 
    resources :attempts
    resources :companies
    resources :answers
    resources :pages

    # This is a page to verify the company key, if the user has not done so already
    get '/verify', :to => 'pages#verify'
    get '/privacy', :to => 'pages#privacy'
    get '/register', :to => 'pages#register'
    get '/help', :to => 'pages#help'
    get '/about', :to => 'pages#about'


    authenticated :user do 
      root 'surveys#index', as: "authenticated_root"
    end 



     root to: "pages#index"

     delete 'attempts/:survey_id/:current_user' => 'attempts#delete_user_attempts', as: :delete_user_attempts

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
