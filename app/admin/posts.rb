ActiveAdmin.register Post do
  # Limit list according to access rights
  scope_to :current_user
  
  filter :organisation
  filter :created_at, :as => :date_range

  scope :all, :default => true
  Rails.application.config.supported_locales.each do |l|
    scope l do |posts|
      posts.where(:locale => l.to_s)
    end
  end

  controller do 
    authorize_resource

    def create 
      create! do |format|
         format.html { redirect_to admin_posts_path } 
      end 
    end 
  end 

  form :title => :title, :partial => "form"

  show :title => :title do |post|
    attributes_table do
      row :title
      row :body do 
        sanitize post.body
      end
      row :locale
      row :organisation
    end
    # active_admin_comments
  end

  index do |post|
    column :title
    column :locale
    column :organisation
    default_actions
  end

end
