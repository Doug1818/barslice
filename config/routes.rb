BarSlice::Application.routes.draw do
  #get "errors/error_404"
  #get "errors/error_500"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: { registrations: "user_registrations", sessions: "user_sessions" }
  devise_for :bars, controllers: { registrations: "bar_registrations" }
  resources :users
  resources :bars do 
    member do
      get :confirm_bar, :add_click
    end
  end
  resources :rooms
  resources :messages do
    member do
      get :bar_view_attachment, :user_view_attachment
    end
  end
  resources :searches
  resources :respolicies
  resources :specials
  resources :rmsprelationships
  resources :reservations do 
    member do
      get :bar_show, :user_show
      put :bar_accepts, :bar_rejects, :user_accepts, :user_rejects
    end
    collection do
      get :bar_index, :user_index
    end
  end

  root              to: 'static_pages#home'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end

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
end
