class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation
  
  scope :dcc, where(:organisation_id => Organisation.dcc.first.id)
  scope :for_organisation, ->(org) { where(:organisation_id => org.id) }
  scope :for_user, ->(user) { where(:user_id => user.id) }
  scope :with_role, ->(role) { where(:role_flags => 2**User::ROLES.index(role.to_s)) }

  def assigned=(role)
    self.role_flags = 2**User::ROLES.index(role.to_s)
  end
  
  def assigned
    User::ROLES.reject { |r| ((roles_mask || 0) & 2**User::ROLES.index(r)).zero? }.map(&:to_sym)
  end
  
end
