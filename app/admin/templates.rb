ActiveAdmin.register Template do 
  # Limit list according to access rights
  scope_to :current_user

  filter :organisation
  filter :locale

  controller.authorize_resource

  index :as => :block do |template|
    div :for => template do
      div :class => 'right' do
        links = link_to I18n.t('dmp.admin.edition_questions'), admin_template_path(template), :class => 'view_link'
        links += link_to I18n.t('dmp.admin.edit_model', :model => I18n.t('activerecord.models.template.one')), edit_admin_template_path(template), :class => 'edit_link'
        if current_user.is_dccadmin? && template.organisation_id == dcc_organisation.id && !template.checklist
          links += link_to I18n.t('dmp.admin.make_checklist'), checklist_admin_template_path(template), :class => 'special_link', :method => :put  
        elsif template.checklist
          links += content_tag :span, I18n.t('dmp.admin.checklist'), :class => 'checklist'
        end
        links 
      end
      h2 template.organisation.full_name

      panel template.name do
        table_for(template.phases) do
          column(I18n.t('activerecord.models.phase.one')) {|p| p.phase }
          column(I18n.t('activerecord.models.edition.other')) do |p|
            raw p.editions.collect{|v| link_to v.edition, admin_edition_path(v)}.join(', ')
          end
          column(I18n.t('attributes.current_edition')) do |p| 
            p.editions.where(:status => Edition::STATUS.index('published')).first.edition rescue span I18n.t('dmp.admin.none'), :class => "empty"
          end
        end
      end

    end
  end

  # TODO: Replace with a redirect to the index layout
  show :title => :name do |template|
    attributes_table do
      row :name
      row :url
      row :organisation
      row :description do 
        sanitize template.description
      end
    end

    table_for(template.editions) do
      column(I18n.t('attributes.phase'), :sortable) {|edition| edition.phase.phase}
      column(I18n.t('attributes.edition')) {|edition| edition.edition}
      column(I18n.t('attributes.status')) {|edition| status_tag(edition.state.to_s)}
      column(I18n.t('dmp.admin.actions')) do |edition|
        case edition.state
        when :active
          links = link_to I18n.t('dmp.admin.view'), admin_edition_path(edition), :class => 'view_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.edit_text'), edit_admin_edition_path(edition), :class => 'edit_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.new_edition'), generate_admin_edition_path(edition), :class => 'edit_link'
          links
        when :published
          links = link_to I18n.t('dmp.admin.view'), admin_edition_path(edition), :class => 'view_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.unpublish'), unpublish_admin_edition_path(edition), :class => 'cancel_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.new_edition'), generate_admin_edition_path(edition), :class => 'edit_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.copy_questions'), copy_admin_edition_path(edition), :class => 'edit_link'
          links
        when :unpublished
          links = link_to I18n.t('dmp.admin.view_publish'), admin_edition_path(edition), :class => 'view_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.edit_questions'), edit_admin_edition_path(edition), :class => 'edit_link'
          links += ' '
          links += link_to I18n.t('dmp.admin.copy_questions'), copy_admin_edition_path(edition), :class => 'edit_link'
          if edition.state != :active
            links += ' '
            links += link_to I18n.t('dmp.admin.delete'), admin_edition_path(edition), :method => :delete, :confirm => I18n.t('dmp.admin.delete_confirm'), :class => 'delete_link'
          end
          links
        when :old
          link_to I18n.t('dmp.admin.view'), admin_edition_path(edition), :class => 'view_link'
        end
      end
    end

    panel I18n.t('dmp.admin.constraints') do
      attributes_table_for(template) do
        row :constraint_text do 
          sanitize(template.constraint_text)
        end
        # row :constraint_limit
      end
    end

  end

  form :title => :name, :partial => "form"

  member_action :checklist, :method => :put do
    if current_user.is_dccadmin?
      template = Template.find(params[:id])
      template.make_checklist(dcc_organisation.id)
    end
    redirect_to :back
  end
  
end
