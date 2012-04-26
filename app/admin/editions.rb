ActiveAdmin.register Edition do
  menu false
  config.clear_sidebar_sections!
  config.clear_action_items!
  scope_to :current_user
  
  action_item :only => :show do
    link_to(I18n.t('dmp.admin.edit_model', model: t('activerecord.models.question.other')), edit_admin_edition_path(edition))
  end
  
  action_item :only => :show do
    case edition.state
    when :unpublished
      link_to(I18n.t('dmp.admin.publish'), publish_admin_edition_path(edition))
    when :published
      link_to(I18n.t('dmp.admin.unpublish'), unpublish_admin_edition_path(edition))
    end
  end

  
  controller do
    authorize_resource

    # This code is evaluated within the controller class
    # Access the Question helper methods
    helper :questions

    def new
      # Do nothing
      redirect_to admin_templates_path
    end
  end

  form :title => :edition, :partial => "form"
  
  index do
    # We don't want anyone to reach this...
    controller.redirect_to admin_templates_path
  end
  
  show :title => :edition do |edition|
    h2 "#{edition.phase.template.organisation.short_name} #{edition.phase.template.name} #{edition.phase.phase}" 
    attributes_table do 
      row :edition
      row :status do
        status_tag(edition.state.to_s)
      end
    end

    q_set = edition.questions.nested_set.all
    number_questions(q_set)
    table_for(q_set) do |q|
      q.column(t('dmp.admin.number'), :number_display)
      q.column(t('dmp.template_question')) {|question| raw question.question }
      q.column(t('attributes.kind')) {|question| question_type_title(question.kind)}
    end

    # active_admin_comments
  end
  
  member_action :copy do
    edition = Edition.find(params[:id])

    new = edition.dup
    new.edition = DateTime.current.to_s(:db)
    new.save!

    redirect_to edit_admin_edition_path(new)
  end

  member_action :generate do
    edition = Edition.find(params[:id])

    new = Edition.new
    new.phase_id = edition.phase_id
    new.edition = (Float(edition.edition) + 1).to_s rescue DateTime.current.to_s(:db)
    new.state= :unpublished
    new.save!

    redirect_to edit_admin_edition_path(new)
  end

  member_action :publish do
    edition = Edition.find(params[:id])
    
    edition.publish
    redirect_to admin_edition_path(edition)    
  end
  
  member_action :unpublish do
    edition = Edition.find(params[:id])
    
    edition.unpublish
    redirect_to admin_edition_path(edition)
  end

 
end
