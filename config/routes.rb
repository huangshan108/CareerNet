Rails.application.routes.draw do

  root :to => 'main#index'
  
  resources :jobs do
    member do
      get 'apply'
    end
  end

  get 'account/login' => 'accounts#login', :as => :account_login
  post 'account/login' => 'accounts#confirm_login', :as => :account_confirm_login
  get 'account/signup' => 'accounts#signup', :as => :account_signup
  post 'account/signup' => 'accounts#confirm_signup', :as => :account_confirm_signup
  get 'account/forgot-password' => 'accounts#forgot_password', :as => :account_forgot_password
  post 'account/reset-password' => 'accounts#reset_password', :as => :account_reset_password
  get 'account/reset_password_confirmation' => 'accounts#reset_password_confirmation', :as => :reset_password_confirmation
  get 'account/start-reset-password/:password_reset_token' => 'accounts#start_reset_password', :as => :account_start_reset_password
  post 'account/start-reset-password/:password_reset_token' => 'accounts#submit_reset_password', :as => :account_submit_reset_password
  get 'account/logout' => 'accounts#logout'

  get 'jobs/' => 'jobs#index', :as => :job_list
  get 'jobs/sort' => 'jobs#job_sort', :as => :job_sort

  get 'profiles/students/' => 'profiles#students'
  get 'profiles/students/page/:page' => 'profiles#list_students', :as => :list_students
  get 'profiles/student/new' => 'profiles#new', :as => :new_student
  post 'profiles/student/new' => 'profiles#create_student',:as => :create_student
  get 'profiles/student/:id' => 'profiles#student', :as => :single_student_profile
  get 'profiles/student/:id/edit' => 'profiles#edit_student', :as => :edit_student_profile
  post 'profiles/student/:id/update' => 'profiles#update_student', :as => :update_student_profile
  get 'profiles/school/:id' => 'profiles#school', :as => :single_school_profile
  
  resources :events

  get 'appointments/staff/:id' => 'appointments#index_staff', :as => :staff_appointments
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
