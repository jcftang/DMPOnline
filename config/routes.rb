Dmponline3::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users, {
    :sign_out_via => [ :post, :delete, :get ],
    :path_names => { :sign_in => 'login', :sign_out => "logout" },
    :controllers => { :registrations => "devise/recaptcha_registrations" }
    }  #, ActiveAdmin::Devise.config, :path => 'session'

  get 'pages/:slug' => 'pages#show', :as => 'pages_slug'
  get '' => 'pages#frontpage', :as => 'frontpage'
  get 'news/:id' => 'posts#show', :as => 'post'
  get 'news' => 'posts#index', :as => 'posts'
  get 'documents' => 'documents#index', :as => 'documents'
  
  resources :plans do
    collection do
      get 'shared'
    end
    member do
      post 'duplicate'
      put 'lock'
      get 'complete'
      get 'output'
      get 'section/:section_id', :action => 'ajax_section', :as => 'ajax_section', :section_id => /\d+/
      put 'phase/:edition_id/set', :action => 'change_phase', :as => 'change_phase', :edition_id => /\d+/
      get 'rights'
      put 'update_rights'
    end

    resources :phase_edition_instances, :only => [:edit, :update], :as => "layer" do
      member do
        get 'checklist/:question_id', :question_id => /\d+/, :action => 'checklist', :as => 'checklist'
        post 'add_answer/:question_id', :question_id => /\d+/, :action => 'add_answer', :as => 'add_answer'
        get 'output'
        get 'output_all'
        # Changed to POST - IE apparently not happy with long URLs and plugins
        post 'export'
      end
    end

  end

  root :to => 'pages#frontpage'

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
  # match ':controller(/:action(/:id(.:format)))'
end
