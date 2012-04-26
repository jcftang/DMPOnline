class TemplateInstanceRight < ActiveRecord::Base
  belongs_to :template_instance
  has_many :phase_edition_instances, :through => :template_instance

  attr_accessible :email_mask, :role_flags
  before_validation :cleanse_email_mask
  validates_format_of :email_mask, with: /^[\\\.\'\-\%\w]+@[-a-z0-9\\\.\%]+$/i

  scope :with_role, ->(role) { where(:role_flags => TemplateInstance::ROLES.index(role)) }
  scope :matching, ->(email) { where("? LIKE email_mask", email) }
  
  def assigned=(roles)
    self.role_flags = TemplateInstance::ROLES.index(role)
  end
  
  def assigned
    TemplateInstance::ROLES[role_flags]
  end
  
  def plan_id
    self.template_instance.plan_id
  end


  protected
  
  def cleanse_email_mask
    self.email_mask.gsub!(/[\"\\]/, '')
    self.email_mask.gsub!(/\.+/, '\.')
    self.email_mask.gsub!(/\*+/, '%')
  end
end
