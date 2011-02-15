Maass2::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users"}

  resources :notifications
  resources :permissions
  resources :accounts
  resources :users
  resources :profiles do
    post 'load_profile', :on => :collection
  end
  resources :blogs  do
    get 'blog_archive', :on => :member
  end
  resources :homes
  resources :friends
  resources :polls do
    get 'poll_close', :on => :member
  end
  resources :votes
  get 'accounts/update_default_permission'

  root :to=>"homes#index"
  resources :blogs
  resources :homes do
    get 'see_my_polls', :on => :member
  end

#  match '/permissions', :to => 'accounts#permissions'

  get 'blogs/preview'
  #get 'profiles/load_profile'
  match '/edit',  :to => 'profiles#edit'
  match '/new',  :to => 'blogs#new'
#  match '/blog_archive/:month/:year', :to => 'blogs#blog_archive'
 
#  match '/user/:user_id/profile/:id',  :to => 'profiles#show'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
