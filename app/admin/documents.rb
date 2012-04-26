ActiveAdmin.register Document do
  # Limit list according to access rights
  scope_to :current_user

  filter :organisation
  filter :visible, :as => :select, :collection => [['Yes', 1], ['No', 0]]
  
  scope :all, :default => true
  Rails.application.config.supported_locales.each do |l|
    scope l do |docs|
      docs.where(:locale => l.to_s)
    end
  end

  controller.authorize_resource
  
  form :html => {:multipart => true}, :title => :title, :partial => "form"

  show :title => :name do |document|
    attributes_table do
      row I18n.t('dmp.admin.download') do
        link_to image_tag(document.icon.url(:thumb), :align => :left, :border => 0), document.attachment.url
      end
      row :attachment_file_size
      row :attachment_updated_at
      row :name
      row :edition
      row :description do 
        sanitize document.description
      end
      row :visible
      row :position
      row :organisation
      row :locale

    end
    # active_admin_comments
  end

  index do 
    column :position
    column I18n.t('dmp.admin.download') do |document|
      link_to image_tag(document.icon.url(:thumb), :align => :left, :border => 0), document.attachment.url if document.icon.file?
    end
    column I18n.t('formtastic.labels.document.name') do |document| 
      link_to document.name, document.attachment.url
    end
    column :edition
    column :attachment_updated_at
    column :visible
    column :organisation
    default_actions
  end

end
