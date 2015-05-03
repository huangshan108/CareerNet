Rails.application.routes.draw do

  # root :to => 'main#index'
  root :to => 'accounts#index'

  get 'dashboard' => 'main#index', :as => :dashboard

  get 'account/index' => 'accounts#index', :as => :account_index
  get 'account/login' => 'accounts#login', :as => :account_login
  post 'account/login' => 'accounts#confirm_login', :as => :account_confirm_login
  get 'account/signup' => 'accounts#signup', :as => :account_signup
  post 'account/signup' => 'accounts#confirm_signup', :as => :account_confirm_signup
  get 'account/forgot-password' => 'accounts#forgot_password', :as => :account_forgot_password
  post 'account/reset-password' => 'accounts#reset_password', :as => :account_reset_password
  get 'account/start-reset-password/:password_reset_token' => 'accounts#start_reset_password', :as => :account_start_reset_password
  post 'account/start-reset-password/:password_reset_token' => 'accounts#submit_reset_password', :as => :account_submit_reset_password
  get 'account/logout' => 'accounts#logout'

  get 'jobs/' => 'jobs#index', :as => :job_list
  get 'jobs/new' => 'jobs#new', :as => :new_job
  post 'jobs/create' => 'jobs#create', :as => :create_job
  get 'jobs/sort' => 'jobs#job_sort', :as => :job_sort
  get 'jobs/:job_id/view' => 'jobs#view', :as => :view_single_job
  get 'jobs/company/:company_id' => 'jobs#view_posted_jobs', :as => :view_posted_jobs
  post 'jobs/apply/:job_id' => 'jobs#apply', :as => :apply_job
  delete 'jobs/delete/:job_id' => 'jobs#delete', :as => :delete_job
  resources :jobs

  get 'profiles/students/' => 'profiles#students'
  get 'profiles/students/page/:page' => 'profiles#list_students', :as => :list_students
  get 'profiles/student/:id' => 'profiles#student', :as => :single_student_profile
  get 'profiles/student/:id/edit' => 'profiles#edit_student', :as => :edit_student_profile
  post 'profiles/student/:id/update' => 'profiles#update_student', :as => :update_student_profile
  post 'profiles/student/:id/updateexperience' => 'profiles#update_past_experience', :as => :update_past_experience
  post 'profiles/student/:id/deleteexperience' => 'profiles#delete_past_experience', :as => :delete_past_experience
  post 'profiles/student/:id/updateproject' => 'profiles#update_past_project', :as => :update_past_project
  post 'profiles/student/:id/deleteproject' => 'profiles#delete_past_project', :as => :delete_past_project
  post 'profiles/student/:id/updateeducation' => 'profiles#update_past_education', :as => :update_past_education
  post 'profiles/student/:id/deleteeducation' => 'profiles#delete_past_education', :as => :delete_past_education
  post 'profiles/student/:id/updateactivity' => 'profiles#update_past_activity', :as => :update_past_activity
  post 'profiles/student/:id/deleteactivity' => 'profiles#delete_past_activity', :as => :delete_past_activity
  get 'profiles/school/:id' => 'profiles#school', :as => :single_school_profile
  get 'profiles/companies/' => 'profiles#companies'
  get 'profiles/company/page/:page' => 'profiles#list_companies', :as => :list_companies
  get 'profiles/company/:id' => 'profiles#company', :as => :company_profile
  get 'profiles/company/:id/edit' => 'profiles#edit_company', :as => :edit_company_profile
  post 'profiles/company/:id/update' => 'profiles#update_company', :as => :update_company_profile
  get 'profiles/staff/:id' => 'profiles#staff', :as => :staff_profile
  get 'profiles/staff/:id/edit' => 'profiles#edit_staff', :as => :edit_staff_profile
  post 'profiles/staff/:id/update' => 'profiles#update_staff', :as => :update_staff_profile

  resources :events
  get 'events/:event_id/register' => 'events#register', :as => :event_register
  get 'events/registered/:account_id' => 'events#registered_index', :as => :registered_event_index
  get 'events/:event_id/attendees' => 'events#attendees_index', :as => :event_attendees_index

  get 'appointments/student/' => 'appointments#student_show', :as => :appointment_student_show
  get 'appointments/student/new' => 'appointments#student_new', :as => :appointment_student_new
  get 'appointments/student/book/:id' => 'appointments#student_book', :as => :appointment_student_book
  post 'appointments/student/update/:id' => 'appointments#student_update', :as => :appointment_student_update
  get 'appointments/student/cancel/:id' => 'appointments#student_cancel', :as => :appointment_student_cancel

  get 'appointments/staff' => 'appointments#index_staff', :as => :staff_appointments
  post 'appointments/staff/new' => 'appointments#staff_new', :as => :new_staff_appointments
  get 'appointments/:id' => 'appointments#show', :as => :show_appointment
  post 'appointments/:id' => 'appointments#staff_update', :as => :update_appointment
  delete 'appointments/staff/:id' => 'appointments#destroy', :as => :cancel_appointment

  get 'appointments' => 'appointments#index', :as => :appointments

  get 'applications/company/:company_id' => 'applications#index', :as => :company_view_applications
  get 'applications/student/:student_id' => 'applications#index', :as => :student_view_applications

  get 'interviews/application/:application_id' => 'interviews#app', :as => :app_int
  get 'interviews/student' => 'interviews#student_show', :as => :interview_student_show
  get 'interviews/student/new/:application_id' => 'interviews#student_new', :as => :interview_student_new
  get 'interviews/student/book/:id' => 'interviews#student_book', :as => :interview_student_book
  get 'interviews/student/cancel/:id' => 'interviews#student_cancel', :as => :interview_student_cancel

  get 'interviews/company' => 'interviews#index_company', :as => :company_interviews
  post 'interviews/company/new' => 'interviews#company_new', :as => :new_company_interviews
  get 'interviews/:id' => 'interviews#show', :as => :show_interview
  post 'interviews/:id' => 'interviews#company_update', :as => :update_interview
  delete 'interviews/company/:id' => 'interviews#destroy', :as => :cancel_interview

  get 'calendar' => 'calendar#view', :as => :calendar
  get 'calendar/appointments' => 'calendar#appointmentData', :as => :calendar_appointment
  get 'calendar/events' => 'calendar#eventData', :as => :calendar_event
  get 'calendar/interviews' => 'calendar#interviewData', :as => :calendar_interview

# The priority is based upon order of creation: first created -> highest priority.

  # Visualization
  get 'smart-report/overview' => 'visualizations#student_demographic', :as => :smart_report
  get 'smart-report/overview-data' => 'visualizations#student_demographic_data', :defaults => { :format => 'json' }, :as => :smart_report_data
  get 'smart-report/industry' => 'visualizations#industry', :as => :smart_report_industry
  get 'smart-report/industry-data' => 'visualizations#industry_data', :defaults => { :format => 'json' }, :as => :smart_report_industry_data
  get 'smart-report/organization' => 'visualizations#organization', :as => :smart_report_organization
  get 'smart-report/organization-data' => 'visualizations#organization_data', :defaults => { :format => 'json' }, :as => :smart_report_organization_data
  get 'smart-report/region' => 'visualizations#salary_by_state', :as => :smart_report_region
  get 'smart-report/region-data' => 'visualizations#salary_by_state_data', :defaults => { :format => 'json' }, :as => :smart_report_region_data

  get 'sign-in-as/student/:id' => 'delegation#as_student', :as => :as_student
  get 'sign-in-as/company/:id' => 'delegation#as_company', :as => :as_company
  get 'cancel-delegation' => 'delegation#switch_back', :as => :cancel_delegation


  get 'not_found' => 'main#not_found'
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
