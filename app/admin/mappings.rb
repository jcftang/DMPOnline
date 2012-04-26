ActiveAdmin.register Mapping do
  menu false
  config.clear_sidebar_sections!
  scope_to :current_user
  
  controller do
    authorize_resource

    # This code is evaluated within the controller class
    # Access the Question helper methods
    helper :questions
    
    def update
      @mapping = Mapping.find(params[:id])

      respond_to do |format|
        if @mapping.update_attributes(params[:mapping])
          format.html do
            redirect_to edit_admin_question_path(@mapping.question_id), notice: t('dmp.admin.mapping_text_updated')
          end
        else
          format.html { render action: "edit" }
        end
      end
    end
 
  end

  form :title => :mapping, :partial => "form"
  
  index do
    # We don't want anyone to reach this...
    controller.redirect_to admin_templates_path
  end
  
  show do
    # We don't want anyone to reach this...
    controller.redirect_to admin_templates_path
  end
   
end
