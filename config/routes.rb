Portal::Application.routes.draw do
  devise_for :admins

  resource :endpoints_configuration, :only => [:edit, :update]

  resources :categories, :only => [:index] do
    resources :products, :only => [:index], :controller => 'category_products'
  end
  resources :brands, :only => [] do
    resources :products, :only => [:index], :controller => 'brand_products'
  end
  resources :products, :only => [:show, :index]

  resources :purchases, :only => [:index, :show, :create] do
    resource :address, :only => [:edit, :update], :controller => 'purchase_address' do
      collection do
        put :cep_address
      end
    end
    resource :delivery, :only => [:edit, :update], :controller => 'purchase_delivery'
    resource :payment, :only => [:edit, :update, :show], :controller => 'purchase_payment' do
      collection do
        get :edit_cc
        put :update_cc
        get :edit_payment_count
        put :update_payment_count
      end
    end
    collection do
      put :update_product
      put :add_product
      get :cart
      delete :delete_product
    end
  end
  
  resource :login, :only => [:new, :create, :destroy]
  
  resources :customer_services, :only => [:new, :create, :edit, :update, :show, :index]
  
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
  root :to => 'categories#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
