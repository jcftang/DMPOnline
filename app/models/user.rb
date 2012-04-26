class User < ActiveRecord::Base
  has_many :posts
  has_many :plans
  has_many :roles
  belongs_to :organisation
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :timeoutable, :encryptable

  # Setup accessible (or protected) attributes for the model
  attr_accessible :password, :password_confirmation, :remember_me, :categories, :email, :email_confirmation, :current_password
  # Currently email address cannot be changed.  Need later version of Devise to ensure changed 
  # email address is confirmed.  This has knock-on for ActiveAdmin...
  # Also implications for access to plans need clearly signposted for users
  attr_readonly :email, :email_confirmation
  validates :email, uniqueness: {case_sensitive: false}, presence: true, confirmation: true

  # User Roles used by DMPOnline
  # sysadmin: can manage everything in the system.
  # dccadmin: can manage the DCC Questions and manage organisations
  # orgadmin: per organisation, can update organisations and dependent templates
  # APPEND ONLY - DO NOT CHANGE ORDER
  ROLES = %w[sysadmin dccadmin orgadmin]
  CATEGORIES = %w[researcher support other]

  before_save :user_default_organisation


  def categories=(cats)
    self.user_types = (cats & CATEGORIES).map { |c| 2**CATEGORIES.index(c) }.sum
  end
  
  def categories
    cats = CATEGORIES.reject { |c| ((self.user_types || 0) & 2**CATEGORIES.index(c)).zero? }
  end
  
   
  def is_admin?
    membership?([:orgadmin, :dccadmin, :sysadmin])
  end

  def is_dccadmin?
    membership?([:dccadmin, :sysadmin])
  end
  
  def is_sysadmin?
    membership?([:sysadmin])
  end
  
  def is_orgadmin?(org)
    self.roles.for_organisation(org).with_role(:orgadmin).empty?
  end
  
  def is_org_admin_for
    self.roles.with_role(:orgadmin).collect(&:organisation_id)
  end

  def membership?(roles)
    mask = (roles.map(&:to_s) & ROLES).map { |r| 2**ROLES.index(r) }.sum
    !self.roles.where("role_flags & #{mask} > 0").empty?
  end
  
  def plan_templates(org)
    # Check whether institutional context
    if org.organisation_type_id.nil?
      Template
        .joins(:organisation, :phases => :editions)
        .joins('LEFT OUTER JOIN organisation_types ON organisations.organisation_type_id = organisation_types.id')
        .where('templates.checklist' => false)
        .where('editions.status' => Edition::STATUS.index('published'))
        .where('editions.dcc_edition_id' => Edition.dcc_checklist_current_edition.try(:id))
        .select('DISTINCT templates.*, organisations.full_name as organisation_name, organisations.organisation_type_id, organisation_types.title as organisation_type_title')
        .order('organisation_types.title ASC, organisations.full_name ASC, templates.name ASC')
        .all
    else
      # Don't use includes for the outer join
      Template
        .joins(:organisation, :phases => :editions)
        .joins('LEFT OUTER JOIN organisation_types ON organisations.organisation_type_id = organisation_types.id')
        .where('templates.checklist' => false)
        .where('editions.status' => Edition::STATUS.index('published'))
        .where('organisations.organisation_type_id <> ? OR templates.organisation_id = ?', org.organisation_type_id, org.id)
        .where('editions.dcc_edition_id' => org.dcc_edition_id)
        .select('templates.*, organisations.full_name as organisation_name, organisations.organisation_type_id, organisation_types.title as organisation_type_title')
        .order('organisation_types.title ASC, organisations.full_name ASC, templates.name ASC')
        .all
    end
  end
  
  # Active admin access rights
  def organisations
    if is_dccadmin?
      Organisation.scoped
    else
      Organisation.joins(:roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def templates
    if is_dccadmin?
      Template.scoped
    else
      Template
        .joins(:organisation => :roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def phases
    if is_dccadmin?
      Phase.scoped
    else
      Phase
        .joins(:template => {:organisation => :roles})
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def editions
    if is_dccadmin?
      Edition.scoped
    else
      Edition
        .joins(:phase => {:template => {:organisation => :roles}})
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def questions
    if is_dccadmin?
      Question.scoped
    else
      Question
        .joins(:edition => {:phase => {:template => {:organisation => :roles}}})
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def mappings
    if is_dccadmin?
      Mapping.scoped
    else
      Mapping
        .joins(:question => {:edition => {:phase => {:template => {:organisation => :roles}}}})
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def pages
    if is_dccadmin?
      Page.scoped
    else
      Page
        .joins(:organisation => :roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def posts
    if is_dccadmin?
     Post.scoped
    else
      Post
        .joins(:organisation => :roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end
  def documents
    if is_dccadmin?
      Document.scoped
    else
      Document
        .joins(:organisation => :roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .readonly(false)
    end
  end

  def org_list
    if is_dccadmin?
      Organisation.all
    else
      Organisation
        .joins(:roles)
        .where('roles.role_flags' => 2**ROLES.index('orgadmin'))
        .where('roles.user_id' => self.id)
        .all
    end
  end      

  private

  def user_default_organisation
    self.organisation = self.organisation || Organisation.where("? LIKE CONCAT('%', domain)", self.email).first
  end

end
