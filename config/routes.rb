WOtracker::Application.routes.draw do
  root 'pages#index'
  get 'login', to: 'users#login'
  post 'login', to: 'users#process_login'
  get 'logout', to: 'users#logout'
  get 'register', to: 'users#new'
  get ':action', to: 'pages'
  post 'contact', to: 'pages#send_message', as: :messages
  post 'users/:user_id/workouts/:id/complete', to: 'completed_workouts#complete', as: :complete_workout
  resources :users, only: [:edit, :create, :destroy, :update] do
    resources :workouts do
      member do
        get 'play'
      end
    end
    member do
      get 'calendar'
      get 'log'
      post 'historyCalendar'
    end
    resources :completed_workouts, only: [:update]
  end
  scope 'api', as: 'api' do
    resources :users, only: [] do
      resources :workouts, only: [ :show, :update ] do
        resources :segments, only: [:create, :update, :destroy, :show] do
          resources :exercises, only: [:create, :update, :destroy, :show]
        end
      end
      resources :completed_workouts, only:[:update, :index]
    end
  end

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
