ActiveAdmin.register Currency do
  menu :if => proc{ current_user.is_dccadmin? }, :priority => 1
  controller.authorize_resource
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :iso_code
      f.input :symbol
    end
    
    f.buttons
  end

  show :title => :name do |c|
    attributes_table do
      row :name
      row :iso_code
      row :symbol
    end
    # active_admin_comments
  end

  index do 
    column :name
    column :iso_code
    column :symbol
    default_actions
  end

end
