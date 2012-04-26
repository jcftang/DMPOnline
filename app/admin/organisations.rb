ActiveAdmin.register Organisation do
  # Limit list according to access rights
  scope_to :current_user
  
  filter :organisation_type
  
  controller.authorize_resource

  form(:html => {:multipart => true}) do |f|
    f.inputs do
      f.input :short_name
      f.input :full_name
      f.input :domain
      f.input :organisation_type
      f.input :logo
      f.input :stylesheet
      f.input :url
    end
    
    f.buttons
  end
  
  index do 
    column :logo do |organisation|
      image_tag(organisation.logo.url(:thumb), :align => :left, :border => 0) if organisation.logo.file?
    end
    column :short_name
    column :full_name
    column :domain
    column :organisation_type
    column :url do |organisation|
      link_to organisation.url, organisation.url
    end
    default_actions
  end
  
  show :title => :full_name do |organisation|
    attributes_table do
      row :short_name
      row :full_name
      row :url
      row :organisation_type
      row :logo do
        image_tag(organisation.logo.url(:template), :align => :left, :border => 0)
      end
      row :logo_file_size
      row :stylesheet_file_name
      row :domain
    end
    # active_admin_comments
  end

end

