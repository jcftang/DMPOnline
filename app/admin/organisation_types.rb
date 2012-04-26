ActiveAdmin.register OrganisationType do
  menu :if => proc{ current_user.is_dccadmin? }, :priority => 1

  config.clear_sidebar_sections!

  controller.authorize_resource

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
    end
    
    f.buttons
  end
  
  index do 
    column :title
    column :description
    default_actions
  end
  
  show :title => :title do
    attributes_table :title, :description 
    # active_admin_comments
  end
 
end
