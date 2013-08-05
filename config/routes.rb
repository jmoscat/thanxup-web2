Myinfo::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  root :to => 'dashboard#index'
  
  devise_for :users, :controllers => { :sessions => 'local_devise/sessions', 
                                       :registrations => 'local_devise/registrations', 
                                       :passwords => 'local_devise/passwords', 
                                       :confirmations => 'local_devise/confirmations', 
                                       :omniauth_callbacks => 'local_devise/omniauth_callbacks'}
  devise_scope :users do
    get '/users', :to => 'dashboard#index', :as => :user_root
  end  

  match '/admin' => 'admin#index'
  match '/dashboard' => 'dashboard#index'
  match '/help' => 'help#index'

  match '/admin/add_new_user' => 'admin#add_new_user', :as => :add_new_user
  match '/admin/:id/update_user' => 'admin#update_user', :as => :update_user
  match '/admin/:id/delete_user' => 'admin#delete_user', :as => :delete_user

  match '/facebox/fb_edit_user' => 'facebox#fb_edit_user', :as => :fb_edit_user
  match '/facebox/fb_create_user' => 'facebox#fb_create_user', :as => :fb_create_user
  match '/facebox/fb_login' => 'facebox#fb_login', :as => :fb_login  
  match '/facebox/fb_reset_password' => 'facebox#fb_reset_password', :as => :fb_reset_password  

end
